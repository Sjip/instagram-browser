require 'httparty'

class InstagramService

  TAG_MEDIA_RECENT_URL = 'https://api.instagram.com/v1/tags/{tag-name}/media/recent?access_token={ACCESS-TOKEN}'

  # Get a list of recently tagged media.
  def get_recent_tagged_media(collection)
    url = TAG_MEDIA_RECENT_URL.sub('{tag-name}', collection.hashtag).sub('{ACCESS-TOKEN}', ENV['INSTAGRAM_ACCESS_TOKEN'])
    json_response = RequestService.new.process_get_request(url)

    prepare_recent_tagged_media_data(json_response, collection)
  end

  def get_next_recent_tagged_media(collection)
    if collection.next_url
      next_data = get_next_data(collection.next_url)
      return prepare_recent_tagged_media_data(next_data, collection) if next_data.present?
    end
    nil
  end

  private

  def get_next_data(next_url)
    return RequestService.new.process_get_request(next_url)
  end


  def prepare_recent_tagged_media_data(json_response, collection)
    raw_media = []

    json_response["data"].each do |data|
      if data["created_time"].to_i >= collection.start_date_unix && data["created_time"].to_i <= collection.end_date_unix
        raw_media << data
      elsif data["comments"]["count"] > 0
        data["comments"]["data"].each do |comment|
          if comment["text"].include?(collection.hashtag)
            data['created_time'] = comment['created_time']
            raw_media << data
          end
        end
      end
    end

    if raw_media.size == 0 && json_response["pagination"]["next_url"].present?
      next_data = get_next_data(json_response["pagination"]["next_url"])
      return prepare_recent_tagged_media_data(next_data, collection)
    end

    media = []
    if raw_media.size > 0
      raw_media.each do |data|
        media << {
          created_time: DateTime.strptime(data['caption']['created_time'],'%s'),
          caption_text: data['caption']['text'],
          media_url:    data['type'] == 'image' ? data['images']['thumbnail']['url'] : data['videos']['standard_resolution']['url'],
          media_type:   data['type'],
          username:     data['user']['username'],
          insta_link:   data['link']
        }
      end
    end

    save_media(media, collection, json_response["pagination"]["next_url"])
    return {pagination: json_response["pagination"], data: media}
  end

  def save_media(media, collection, next_url)
    collection.update(next_url: next_url)
    media.each do |m|
      InstagramContent.create(m.merge({collection_id: collection.id}))
    end
  end
  
end
class CollectionsController < ApplicationController
  def show
    if params[:id]
      id = params[:id].to_i
      @collection = Collection.find_by_id(id)

      if params[:new_data] == 'true'
        InstagramService.new.get_next_recent_tagged_media(@collection)
      elsif @collection.instagram_contents.blank?
        InstagramService.new.get_recent_tagged_media(@collection) 
      end
      
      @instagram_contents = Collection.find_by_id(id).instagram_contents.order('id asc').page params[:page]

      if params[:new_data] == 'true'
        last_page = @instagram_contents.num_pages
        @instagram_contents = Collection.find_by_id(id).instagram_contents.order('id asc').page last_page
        params[:new_data] = 'false'
      end

      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @collection = Collection.create(collections_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def collections_params
    params.require(:collection).permit(
      :end_date,
      :hashtag,
      :start_date)
  end
end
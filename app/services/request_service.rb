require 'httparty'

class RequestService
  def process_get_request(url)
    if url.present?
      response = send_get_request(url)
      return parse_response_to_json(response) if response.present?
    end
    nil
  end

  private

  def send_get_request(url)
    begin
      response = HTTParty.get(url)       
    rescue Exception => e
      return nil
    end
    response
  end

  def parse_response_to_json(response)
    begin
      json_response = JSON.parse(response.body)         
    rescue JSON::ParserError => e
      return nil
    end
    json_response
  end

end
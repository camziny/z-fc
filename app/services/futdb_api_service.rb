class FutdbApiService
  require 'net/http'
  require 'uri'
  require 'json'

  BASE_URL = 'https://futdb.app/api/players'

  def self.fetch_players(page: 1, search: nil, sort: nil)
    page = 1 if page.blank?
    uri = URI(BASE_URL)
    params = { page: page }
    uri.query = URI.encode_www_form(params)

    request = Net::HTTP::Get.new(uri)
    request['Accept'] = 'application/json'
    request['X-AUTH-TOKEN'] = ENV['FUTDB_API_TOKEN']

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end


    if response.is_a?(Net::HTTPSuccess)
      response_body = JSON.parse(response.body)
    else
      Rails.logger.error "FUTDB API Error: Status: #{response.code}, Body: #{response.body}"
      nil
    end
  end
end

class FutdbApiService
  BASE_URL = 'https://futdb.app/api/players'

  def self.fetch_player_details(player_id)
    uri = URI("#{BASE_URL}/#{player_id}")
    request = Net::HTTP::Get.new(uri)
    request['Accept'] = 'application/json'
    request['X-AUTH-TOKEN'] = ENV['FUTDB_API_TOKEN']

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)['player']
    else
      Rails.logger.error "FUTDB API Error: Status: #{response.code}, Body: #{response.body}"
      nil
    end
  end
end


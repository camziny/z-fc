require 'httparty'

module PlayersHelper
  def fetch_nation_name(nation_id)
    api_key = ENV['FUTDB_API_TOKEN']
    response = HTTParty.get("https://futdb.app/api/nations/#{nation_id}", headers: { "X-AUTH-TOKEN" => api_key })
    response.parsed_response['nation']['name'] if response.code == 200
  end

  def fetch_club_name(club_id)
    api_key = ENV['FUTDB_API_TOKEN']
    response = HTTParty.get("https://futdb.app/api/clubs/#{club_id}", headers: { "X-AUTH-TOKEN" => api_key })
    response.parsed_response['club']['name'] if response.code == 200
  end

  def fetch_league_name(league_id)
    api_key = ENV['FUTDB_API_TOKEN']
    response = HTTParty.get("https://futdb.app/api/leagues/#{league_id}", headers: { "X-AUTH-TOKEN" => api_key })
    response.parsed_response['league']['name'] if response.code == 200
  end

  def fetch_card_rarity(rarity_id)
    api_key = ENV['FUTDB_API_TOKEN']
    response = HTTParty.get("https://futdb.app/api/rarities/#{rarity_id}", headers: { "X-AUTH-TOKEN" => api_key })
    response.parsed_response['rarity']['name'] if response.code == 200
  end

end


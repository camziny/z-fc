require 'httparty'

class PlayersController < ApplicationController
  before_action :set_player, only: [:edit, :update, :destroy]

  def index
    page = params[:page].presence || 1
    players_response = FutdbApiService.fetch_players(page: page)
  
    if players_response && players_response['items'].is_a?(Array)
      filtered_players = filter_players_by_name(players_response['items'], params[:search])
      @players = sort_players(filtered_players, params[:sort])
      @pagination = PaginationWrapper.new(players_response['pagination'])
    else
      @players = []
      @pagination = PaginationWrapper.new({ 'pageTotal' => 0, 'pageCurrent' => 0 })
    end
  end
  
  
  def sort_players(players, sort_criteria)
    return players unless sort_criteria.present?
  
    sorted_players = players.sort_by do |player|
      case sort_criteria
      when 'rating' then -player['rating'].to_i
      when 'pace' then -player['pace'].to_i
      when 'shooting' then -player['shooting'].to_i
      when 'passing' then -player['passing'].to_i
      when 'dribbling' then -player['dribbling'].to_i
      when 'defending' then -player['defending'].to_i
      when 'physicality' then -player['physicality'].to_i
      else player['name']
      end
    end
    sorted_players
  end
  
  def filter_players_by_name(players, search_name, threshold = 2)
    return players if search_name.blank?

    players.select do |player|
      first_name = player['firstName'] || ""
      last_name = player['lastName'] || ""
      levenshtein_distance(first_name.downcase, search_name.downcase) <= threshold ||
        levenshtein_distance(last_name.downcase, search_name.downcase) <= threshold
    end
  end

  

  def levenshtein_distance(str1, str2)
    m = str1.length
    n = str2.length
    return m if n == 0
    return n if m == 0
    matrix = Array.new(m+1) { Array.new(n+1) }
  
    (0..m).each { |i| matrix[i][0] = i }
    (0..n).each { |j| matrix[0][j] = j }
  
    (1..m).each do |i|
      (1..n).each do |j|
        cost = str1[i-1] == str2[j-1] ? 0 : 1
        matrix[i][j] = [matrix[i-1][j] + 1, matrix[i][j-1] + 1, matrix[i-1][j-1] + cost].min
      end
    end
  
    matrix[m][n]
  end
  
  
  # GET /players/:id
  def show
    @player = FutdbApiService.fetch_player_details(params[:id])
  end

  def image
    player_id = params[:id]
    api_key = ENV['FUTDB_API_TOKEN']
    response = HTTParty.get("https://futdb.app/api/players/#{player_id}/image", headers: { "X-AUTH-TOKEN" => api_key })
    send_data response.body, type: response.headers['Content-Type'], disposition: 'inline'
  end

  def nation_image
    nation_id = params[:id]
    api_key = ENV['FUTDB_API_TOKEN']
    response = HTTParty.get("https://futdb.app/api/nations/#{nation_id}/image", headers: { "X-AUTH-TOKEN" => api_key })  
    send_data response.body, type: response.headers['Content-Type'], disposition: 'inline'
  end  

  def club_image
    club_id = params[:id]
    api_key = ENV['FUTDB_API_TOKEN']
    response = HTTParty.get("https://futdb.app/api/clubs/#{club_id}/image", headers: { "X-AUTH-TOKEN" => api_key })  
    send_data response.body, type: response.headers['Content-Type'], disposition: 'inline'
  end 

  def league_image
    league_id = params[:id]
    api_key = ENV['FUTDB_API_TOKEN']
    response = HTTParty.get("https://futdb.app/api/leagues/#{league_id}/image", headers: { "X-AUTH-TOKEN" => api_key })  
    send_data response.body, type: response.headers['Content-Type'], disposition: 'inline'
  end 

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @player.update(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @player.destroy
    redirect_to players_url, notice: 'Player was successfully destroyed.'
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :position, :identifier)
  end  
end

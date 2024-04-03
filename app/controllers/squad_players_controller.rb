class SquadPlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_squad

  def create
    squad = Squad.find(params[:squad_id])
    api_player_id = params[:player_id]
    position = params[:position]
  
    api_player_data = FutdbApiService.fetch_player_details(api_player_id)

    Rails.logger.debug "API Player Data: #{api_player_data.inspect}"
  
    if api_player_data
      player = Player.find_or_create_by(api_id: api_player_id) do |new_player|
        new_player.name = api_player_data['name']
        new_player.position = position
        new_player.rating = api_player_data['rating']
        new_player.nation = api_player_data['nation']
        new_player.club = api_player_data['club']
        new_player.league = api_player_data['league']
        new_player.pace = api_player_data['pace']
        new_player.shooting = api_player_data['shooting']
        new_player.passing = api_player_data['passing']
        new_player.dribbling = api_player_data['dribbling']
        new_player.defending = api_player_data['defending']
        new_player.physicality = api_player_data['physicality']
      end
  
      squad_player = SquadPlayer.new(squad: squad, player: player, position: position)
  
      if squad_player.save
        Rails.logger.debug "Redirecting to: #{params[:return_to]}"
        redirect_to params[:return_to] || new_squad_path(squad), notice: "#{player.name} added as #{position}"
      else
        redirect_to players_path, alert: "Failed to add player to squad"
      end
    else
      redirect_to players_path, alert: "Failed to fetch player data from FUT DB API"
    end
  end
  

  def destroy
    @squad_player = @squad.squad_players.find(params[:id])
    @squad_player.destroy
    redirect_to @squad, notice: 'Player was successfully removed from the squad.'
  end

  def remove_player
    squad = Squad.find(params[:id])
    position = params[:position]
  
    squad_player = squad.squad_players.find_by(position: position)
    squad_player.destroy if squad_player
  
    redirect_to edit_squad_path(squad), notice: "Player removed from #{position}"
  end
  

  private

  def set_squad
    @squad = current_user.squads.find(params[:squad_id])
  end
end

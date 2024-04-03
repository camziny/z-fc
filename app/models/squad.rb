class Squad < ApplicationRecord
  belongs_to :user
  has_many :squad_players, dependent: :destroy
  has_many :players, through: :squad_players
  accepts_nested_attributes_for :squad_players, allow_destroy: true

  POSITIONS = [
    'GK',
    'RB',
    'RCB',
    'LCB',
    'LB',
    'RCM',
    'CM',
    'LCM',
    'RW',
    'LW',
    'ST',
  ].freeze

  def player_for_position(position)
    squad_player = squad_players.find_by(position: position)
    return nil unless squad_player
  
    player_data = FutdbApiService.fetch_player_details(squad_player.player.api_id)
    player_data
  end
  
end

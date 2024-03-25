class Player < ApplicationRecord
  has_many :squad_players, dependent: :destroy
  has_many :squads, through: :squad_players
end

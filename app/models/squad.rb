class Squad < ApplicationRecord
  belongs_to :user
  has_many :squad_players, dependent: :destroy
  has_many :players, through: :squad_players
end

class SquadPlayer < ApplicationRecord
  belongs_to :squad
  belongs_to :player
  validates :position, presence: true, inclusion: { in: Squad::POSITIONS }
end

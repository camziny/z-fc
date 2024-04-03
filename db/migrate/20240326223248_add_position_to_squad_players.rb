class AddPositionToSquadPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :squad_players, :position, :string
  end
end

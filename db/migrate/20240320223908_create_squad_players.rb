class CreateSquadPlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :squad_players do |t|
      t.references :squad, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end

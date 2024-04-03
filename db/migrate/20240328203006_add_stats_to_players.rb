class AddStatsToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :rating, :integer
    add_column :players, :nation, :integer
    add_column :players, :club, :integer
    add_column :players, :league, :integer
    add_column :players, :pace, :integer
    add_column :players, :shooting, :integer
    add_column :players, :passing, :integer
    add_column :players, :dribbling, :integer
    add_column :players, :defending, :integer
    add_column :players, :physicality, :integer
  end
end

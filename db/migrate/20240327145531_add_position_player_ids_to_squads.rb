class AddPositionPlayerIdsToSquads < ActiveRecord::Migration[7.0]
  def change
    add_column :squads, :gk_player_id, :integer
    add_column :squads, :rb_player_id, :integer
    add_column :squads, :rcb_player_id, :integer
    add_column :squads, :lcb_player_id, :integer
    add_column :squads, :lb_player_id, :integer
    add_column :squads, :rcm_player_id, :integer
    add_column :squads, :cm_player_id, :integer
    add_column :squads, :lcm_player_id, :integer
    add_column :squads, :rw_player_id, :integer
    add_column :squads, :lw_player_id, :integer
    add_column :squads, :striker_player_id, :integer
  end
end

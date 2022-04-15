class AddPlayerOneIndexToMatches < ActiveRecord::Migration[7.0]
  def change
    add_index :matches, :player_one_id
    add_index :matches, :player_two_id
  end
end

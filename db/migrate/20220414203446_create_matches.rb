class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :player_one_id, null: false, foreign_key: true
      t.integer :player_two_id, null: false, foreign_key: true
      t.string :result, null: false

      t.timestamps
    end
  end
end

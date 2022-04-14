class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.date :birthday
      t.integer :games_played
      t.integer :rank

      t.timestamps
    end
  end
end

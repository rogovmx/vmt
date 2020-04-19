class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :name
      t.integer :team1_id, index: true
      t.integer :team2_id, index: true

      t.timestamps
    end
  end
end

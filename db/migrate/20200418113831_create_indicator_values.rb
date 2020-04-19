class CreateIndicatorValues < ActiveRecord::Migration[5.2]
  def change
    create_table :indicator_values do |t|
      t.belongs_to :player, index: true
      t.belongs_to :match, index: true
      t.belongs_to :indicator, index: true
      t.boolean :val

      t.timestamps
    end
  end
end

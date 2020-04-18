class CreateIndicators < ActiveRecord::Migration[5.2]
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :val

      t.timestamps
    end
  end
end

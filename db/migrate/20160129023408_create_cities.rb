class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :state, index: true, foreign_key: true
      t.boolean :capital
      t.string :name

      t.timestamps null: false
    end
  end
end

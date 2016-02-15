class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :lati
      t.string :longi
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.string :neighborhood
      t.string :cep

      t.timestamps null: false
    end
  end
end

class CreateDemands < ActiveRecord::Migration
  def change
    create_table :demands do |t|
      t.string :title
      t.string :observation
      t.string :period
      t.date :start_at
      t.integer :how_many
      t.string :status
      t.integer :accepted_by
      t.integer :created_by
      t.references :school, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

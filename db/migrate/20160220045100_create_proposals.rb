class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.references :user, index: true, foreign_key: true
      t.references :demand, index: true, foreign_key: true
      t.string :status
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.integer :how_many

      t.timestamps null: false
    end
  end
end

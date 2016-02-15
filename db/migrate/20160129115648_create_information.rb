class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.references :user, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.string :school
      t.date :expected_finish
      t.string :work_at
      t.string :occupation

      t.timestamps null: false
    end
  end
end

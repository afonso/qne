class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, force: :cascade do |t|
      t.string :name
      t.date :birthday

      t.timestamps null: false
    end
  end
end

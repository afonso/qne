class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :user, index: true
      t.string :city
      t.string :state
      t.string :whatsapp
      t.string :phone      

      t.timestamps null: false
    end
  end
end

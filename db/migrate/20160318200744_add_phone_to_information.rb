class AddPhoneToInformation < ActiveRecord::Migration
  def change
    add_column :information, :phone, :string
  end
end

class AddAvatarToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :avatar, :string
  end
end

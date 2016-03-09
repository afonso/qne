class AddSchoolNameToInformation < ActiveRecord::Migration
  def change
    add_column :information, :school_name, :string
  end
end

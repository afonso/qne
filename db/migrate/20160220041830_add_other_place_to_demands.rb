class AddOtherPlaceToDemands < ActiveRecord::Migration
  def change
    add_column :demands, :other_place, :boolean
  end
end

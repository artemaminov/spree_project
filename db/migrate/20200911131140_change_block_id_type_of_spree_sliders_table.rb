class ChangeBlockIdTypeOfSpreeSlidersTable < ActiveRecord::Migration[5.2]
  def change
    change_column :spree_sliders, :page_id, :string, null: true
  end
end

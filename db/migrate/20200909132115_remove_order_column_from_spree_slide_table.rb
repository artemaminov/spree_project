class RemoveOrderColumnFromSpreeSlideTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :spree_slides, :order
  end
end

class AddPositionToGalleries < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_galleries, :position, :integer
  end
end

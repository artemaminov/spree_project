# This migration comes from spree_image_combine (originally 20200731140530)
class RenameImagesPositionsTypesTableToImagesPositions < ActiveRecord::Migration[5.2]
  def change
    rename_table :spree_images_positions_types, :spree_images_positions
  end
end

# This migration comes from spree_image_combine (originally 20200801102636)
class AddMultipleColumnToImageCombineBlockTypeTable < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_image_combine_block_types, :multiple, :boolean, default: false
  end
end

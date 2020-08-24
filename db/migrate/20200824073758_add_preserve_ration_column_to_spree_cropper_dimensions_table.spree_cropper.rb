# This migration comes from spree_cropper (originally 20200824073557)
class AddPreserveRationColumnToSpreeCropperDimensionsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_cropper_dimensions, :preserve_ratio, :boolean, default: true
  end
end

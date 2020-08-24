# This migration comes from spree_cropper (originally 20200801104050)
class RenameCropperDevicesTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :spree_cropper_devices, :spree_cropper_dimensions
  end
end

class AddPropertiesToVariantsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_variants, :sqr_meter_amount, :integer
    add_column :spree_variants, :pallet_quantity, :integer
    add_column :spree_variants, :car_load, :integer
    add_column :spree_variants,:pallet_dimension, :string, limit: 14
    add_column :spree_variants,:dimension, :string, limit: 11
  end
end

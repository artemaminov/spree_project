class AddDimensionsAndIconColumnsToOptionValueTable < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_option_values, :width, :integer
    add_column :spree_option_values, :height, :integer
    add_column :spree_option_values, :depth, :integer
    add_column :spree_option_values, :icon, :string
  end
end

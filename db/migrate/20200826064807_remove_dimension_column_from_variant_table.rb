class RemoveDimensionColumnFromVariantTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :spree_variants, :dimension
  end
end

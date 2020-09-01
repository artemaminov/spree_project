class RenameWeightProduts < ActiveRecord::Migration[5.2]
  def change
    rename_column :spree_products, :weight, :position
  end
end

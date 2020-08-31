class CreateSpreeGalleryProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_gallery_products do |t|
      t.integer :product_id
      t.integer :gallery_id

      t.timestamps
    end
  end
end

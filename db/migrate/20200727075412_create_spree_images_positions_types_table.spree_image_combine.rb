# This migration comes from spree_image_combine (originally 20200724054432)
class CreateSpreeImagesPositionsTypesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_images_positions_types do |t|
      t.references :image_combine, foreign_key: { to_table: :spree_image_combines }
      t.references :block_position, foreign_key: { to_table: :spree_image_combine_block_positions }
      t.integer :order, default: 1
    end
  end
end

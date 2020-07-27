# This migration comes from spree_image_combine (originally 20200723073246)
class CreateSpreeImageCombineBlockPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_image_combine_block_positions do |t|
      t.string :controller_name, null: false
      t.string :block_id
      t.references :block_type
      t.string :name, null: false

      t.timestamps
    end
  end
end

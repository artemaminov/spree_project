# This migration comes from spree_image_combine (originally 20200723073722)
class CreateSpreeImageCombineBlockTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_image_combine_block_types do |t|
      t.string :name, null: false
      t.string :model_class_name, null: false
      t.integer :width, null: false
      t.integer :height, null: false

      t.timestamps
    end
  end
end

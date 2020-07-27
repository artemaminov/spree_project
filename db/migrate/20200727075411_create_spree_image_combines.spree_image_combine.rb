# This migration comes from spree_image_combine (originally 20200723073907)
class CreateSpreeImageCombines < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_image_combines do |t|
      t.timestamps
    end
  end
end

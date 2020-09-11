# This migration comes from spree_image_combine (originally 20200907062037)
class AddCombinableColumnToImageCombineTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :spree_image_combines, :combinable, polymorphic: true, index: true
  end
end

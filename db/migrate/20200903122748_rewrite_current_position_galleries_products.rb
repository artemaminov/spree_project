class RewriteCurrentPositionGalleriesProducts < ActiveRecord::Migration[5.2]
  def change
    Spree::Gallery.all.order(id: :asc).each_with_index.map{|g, i| g.update(position: i + 1)}
    Spree::Product.all.order(id: :asc).each_with_index.map{|g, i| g.update(position: i + 1)}
  end
end

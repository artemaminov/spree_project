class FillGalleriesPosition < ActiveRecord::Migration[5.2]
  def change
    Spree::Gallery.all.order(id: :asc).each do |g|
      g.update(position: g.id)
    end
  end
end

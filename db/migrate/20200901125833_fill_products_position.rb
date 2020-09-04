class FillProductsPosition < ActiveRecord::Migration[5.2]
  def change
    Spree::Product.all.order(id: :asc).each_with_index do |p, i|
      p.update(position: i)
    end
  end
end

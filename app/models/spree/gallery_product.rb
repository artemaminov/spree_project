module Spree
    class GalleryProduct < Spree::Base
        belongs_to :product, class_name: "Spree::Product", foreign_key: :product_id
        belongs_to :gallery, class_name: "Spree::Gallery", foreign_key: :gallery_id
        # validates :name, :page_id, :file, presence: true

        # has_one_attached :file
    end
end
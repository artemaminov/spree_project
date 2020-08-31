module Spree
    class Gallery < Spree::Base
        validates :title, :subtitle, :main_image, :preview_image, presence: true

        has_many :gallery_products, class_name: "Spree::GalleryProduct"
        has_many :products, class_name: "Spree::Product",
                 through: :gallery_products

        has_one_attached :preview_image
        has_one_attached :main_image
        has_many_attached :images

        if defined?(SpreeGlobalize)
            translates :title, :subtitle, :desc, fallbacks_for_empty_translations: true
            # include SpreeGlobalize::Translatable
        end
    end
end
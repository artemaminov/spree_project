module Spree
  class Gallery < Spree::Base
    acts_as_list

    validates :title, :subtitle, presence: true

    has_many :gallery_products, class_name: 'Spree::GalleryProduct'
    has_many :products, class_name: 'Spree::Product',
                        through: :gallery_products

    has_one_attached :preview_image
    has_many_attached :images
    has_one_attached :main_image
    has_one :slider_image, class_name: 'Spree::ImageCombine', as: :combinable

    accepts_nested_attributes_for :slider_image

    if defined?(SpreeGlobalize)
      translates :title, :subtitle, :desc, fallbacks_for_empty_translations: true
      # include SpreeGlobalize::Translatable
    end

    def return_to_catalog
      if products.any?
        @return_to_catalog = products.first.taxon_to_return_to
      else
        Spree::Taxon.first
      end
    end

    def next
      Spree::Gallery.where('id > ?', id).order('id ASC').first || Spree::Gallery.first
    end

    def previous
      Spree::Gallery.where('id < ?', id).order('id DESC').first || Spree::Gallery.last
    end
  end
end

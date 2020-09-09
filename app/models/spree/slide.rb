module Spree
  class Slide < Spree::Base
    has_and_belongs_to_many :sliders, :class_name => 'Spree::Slider', join_table: 'spree_sliders_slides'
    has_one :image, class_name: 'Spree::ImageCombine', as: :combinable

    accepts_nested_attributes_for :image

    validates_presence_of :title, :message, :order

    if defined?(SpreeGlobalize)
      translates :title, :message, fallbacks_for_empty_translations: true
      include SpreeGlobalize::Translatable
    end

  end
end

module Spree
  class Slide < Spree::Base
    has_one :cropped_image,as: :viewable, dependent: :destroy, class_name: 'Spree::CroppedImage'
    has_and_belongs_to_many :sliders, :class_name => 'Spree::Slider', join_table: 'spree_sliders_slides'

    accepts_nested_attributes_for :cropped_image, allow_destroy: true
    accepts_nested_attributes_for :sliders

    validates_presence_of :title, :message, :order

    if defined?(SpreeGlobalize)
      translates :title, :message, fallbacks_for_empty_translations: true
      include SpreeGlobalize::Translatable
    end

  end
end

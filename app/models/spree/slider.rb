module Spree
  class Slider < Spree::Base
    has_one :cropped_image, as: :viewable, dependent: :destroy

    accepts_nested_attributes_for :cropped_image, allow_destroy: true

    validates :title, :message, :position, presence: true

    if defined?(SpreeGlobalize)
      translates :title, :message, :url, :position, fallbacks_for_empty_translations: true
      include SpreeGlobalize::Translatable
    end

  end
end

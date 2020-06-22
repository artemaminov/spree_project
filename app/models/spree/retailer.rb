# frozen_string_literal: true

# name, lat, lng, image, address, web_site, email, phone, disabled
module Spree
  class Retailer < Spree::Base
    validates :name, :lat, :lng, presence: true

    has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::SharedImage'

    translates :region, :name, :address, fallbacks_for_empty_translations: true
    include SpreeGlobalize::Translatable

    belongs_to :retailer_region, class_name: 'Spree::RetailerRegion'

    scope :enabled, -> { where(disabled: false) }
  end
end

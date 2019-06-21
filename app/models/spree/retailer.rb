#region, name, lat, lng, image, address, web_site, email, phone, disabled
module Spree
  class Retailer < Spree::Base
    validates :name, :region, :lat, :lng, :presence => true

    has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::RetailerImage'

    translates :region, :name, :address, fallbacks_for_empty_translations: true

    scope :enabled, -> { where(disabled: false) }
  end
end


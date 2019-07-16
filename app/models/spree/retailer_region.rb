#name, lat, lng, disabled, active_on_home
module Spree
  class RetailerRegion < Spree::Base
    validates :name, :lat, :lng, :presence => true

    translates :name, fallbacks_for_empty_translations: true
    include SpreeGlobalize::Translatable

    has_many :spree_retailers, class_name: 'Spree::Retailer'

    scope :enabled, -> { where(disabled: false) }
  end
end

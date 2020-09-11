module Spree
  class Slider < Spree::Base
    has_and_belongs_to_many :slides, :class_name => 'Spree::Slide', join_table: 'spree_sliders_slides'

    validates_presence_of :page

    if defined?(SpreeGlobalize)
      translates :name, fallbacks_for_empty_translations: true
      include SpreeGlobalize::Translatable
    end

    def self.for_page(controller_name, page_id)
      page_id = [nil, ''] if page_id.blank?
      where(page: controller_name, page_id: page_id).first
    end

  end
end

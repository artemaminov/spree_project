module Spree
  class PageSection < Spree::Base
    has_one :cropped_image, as: :viewable, dependent: :destroy

    accepts_nested_attributes_for :cropped_image, allow_destroy: true

    validates :title, :description, :html_section_name, presence: true
    validates :button_url, presence: true, if: :button_text?

    if defined?(SpreeGlobalize)
      translates :title, :description, :button_text, :button_url, :html_section_name, :button_style, :button_centered, fallbacks_for_empty_translations: true
      include SpreeGlobalize::Translatable
    end

    def self.section(section)
      where({ html_section_name: section }).first
    end
  end
end

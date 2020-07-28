module Spree
  class Slider < Spree::Base
    has_and_belongs_to_many :slides, :class_name => 'Spree::Slide', join_table: 'spree_sliders_slides'

    accepts_nested_attributes_for :slides

    validates_presence_of :page

    def self.for_page(name, page_id)
      page_id = [nil, ''] if page_id.blank?
      where(page: name, page_id: page_id).first
    end

  end
end

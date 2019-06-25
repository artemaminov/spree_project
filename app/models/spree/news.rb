# name, short_info, body, image, show_on_site, publication_date, latest, meta_title, meta_description, meta_keywords, slug
module Spree
  class News < Spree::Base
    extend FriendlyId
    friendly_id :name, use: :slugged, routes: :default

    validates :name, :body, :presence => true

    has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::NewsImage'

    translates :name, :short_info, :body, :meta_title, :meta_description, :meta_keywords,
               fallbacks_for_empty_translations: true

    default_scope  -> { order(publication_date: :desc) }

    scope :visible, -> { where(show_on_site: true) }
    scope :latest, -> { where(latest: true) }

    before_validation :normalize_slug

    validates :slug, uniqueness: true

    def normalize_slug
      self.slug = normalize_friendly_id(name)
    end
  end
end


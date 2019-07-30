# frozen_string_literal: true

module Spree
  Vendor.class_eval do
    clear_validators!

    extend FriendlyId

    translates :name, :slug, fallbacks_for_empty_translations: true
    include SpreeGlobalize::Translatable

    validates_associated :image
    validates :notification_email, email: true, allow_blank: true

    before_validation :normalize_slug

    validates :name,
              presence: true,
              uniqueness: { case_sensitive: false },
              format: { with: /\A[A-Za-z0-9А-Яа-я\ ]+\z/,
                        message: Spree.t('only_alphanumeric_chars') }

    validates :slug, uniqueness: true

    def normalize_slug
      self.slug = normalize_friendly_id(slug)
    end
  end
end

module Spree
  Page.class_eval do

    has_many_attached :gallery_images
    has_many_attached :attachments
    has_many :file_attachments
    accepts_nested_attributes_for :file_attachments, allow_destroy: true
    validates_associated :file_attachments
  end
end

# fields: name, published_at
module Spree
  class FileAttachment < Spree::Base

    validates :name, :page_id, :file, :presence => true

    has_one_attached :file
  end
end


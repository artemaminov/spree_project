module Spree
  class PageSectionImage < Asset
    module Configuration
      module ActiveStorage
        extend ActiveSupport::Concern

        included do
          validate :check_attachment_content_type

          has_one_attached :attachment

          def self.styles
            # byebug
            @styles ||= {
                desktop: '1440x400>',
                tablet_landscape: '1024x300>',
                tablet_portrait: '600x200>',
                mobile: '200x200>'
            }
          end

          def default_style
            :desktop
          end

          def accepted_image_types
            %w(image/jpeg image/jpg image/png image/gif)
          end

          def check_attachment_content_type
            if attachment.attached? && !attachment.content_type.in?(accepted_image_types)
              errors.add(:attachment, :not_allowed_content_type)
            end
          end
        end
      end
    end
  end
end

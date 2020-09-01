module Spree
    class EntityFile < Spree::Base
        has_one_attached :image

        after_create :set_file_id

        def set_file_id
            update(file_id: self.image.attachment.id)
        end
    end
end
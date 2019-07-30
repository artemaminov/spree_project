# frozen_string_literal: true

module Spree
  module Admin
    class AttachmentsController < StoreController
      def destroy
        @attachment_id = params[:attachment_id]
        image = ActiveStorage::Attachment.find(@attachment_id)
        image.purge_later
        respond_to do |format|
          format.js
        end
      end
    end
  end
end

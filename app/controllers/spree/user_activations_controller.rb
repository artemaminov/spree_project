# frozen_string_literal: true

module Spree
  class UserActivationsController < StoreController
    def index

    end

    def send_email
      @success = false

      if(spree_user_signed_in?)
        spree_current_user.send_confirmation_instructions
        @success = true
      end

      respond_to do |format|
        format.js
      end
    end
  end
end

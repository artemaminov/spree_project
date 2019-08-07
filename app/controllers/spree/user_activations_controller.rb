# frozen_string_literal: true

module Spree
  class UserActivationsController < StoreController
    def index

    end

    def check_email
      if(!email_params)
        return render json: render_error_message(Spree.t(:email_not_found, scope: :activations)), status: bad_request
      end

      user = find_by_email
      if(user)
        render json: render_success_message({ not_exist: false }), status: status_ok
      else
        render json: render_success_message({ not_exist: true }), status: status_ok
      end
    end

    def check_phone_number
      if(!phone_number_params)
        return render json: render_error_message(Spree.t(:phone_number_not_found, scope: :activations)), status: bad_request
      end

      user = find_by_phone
      if(user)
        render json: render_success_message({ not_exist: false }), status: status_ok
      else
        render json: render_success_message({ not_exist: true }), status: status_ok
      end
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

    private

    def user_collection
      Spree::User.all
    end

    def find_by_phone
      user_collection.find_by(phone_number: phone_number_params)
    end

    def find_by_email
      user_collection.find_by(email: email_params)
    end

    def email_params
      params[:email]
    end

    def phone_number_params
      params[:phone_number]
    end
  end
end

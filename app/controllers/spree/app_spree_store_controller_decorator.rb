# frozen_string_literal: true

Spree::StoreController.class_eval do
  include Rails.application.routes.url_helpers
  include CheckoutHelper
end

# frozen_string_literal: true

# name, phone, email_sent
module Spree
  class Question < Spree::Base
    validates :name, :phone, presence: true
  end
end

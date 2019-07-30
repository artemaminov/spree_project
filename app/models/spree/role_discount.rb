# frozen_string_literal: true

# role_id, discount
module Spree
  class RoleDiscount < Spree::Base
    validates :discount, presence: true

    belongs_to :role, class_name: 'Spree::Role'
  end
end

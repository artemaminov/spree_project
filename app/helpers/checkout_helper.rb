# frozen_string_literal: true

module CheckoutHelper
  def current_user_discount
    discount = 0

    spree_current_user&.role_user_ids&.each do |id|
      role_discount = Spree::RoleDiscount.find_by(role_id: id)
      if role_discount && role_discount.discount > discount
        discount = role_discount.discount
      end
    end

    discount / 100.to_f
  end
end

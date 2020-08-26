# frozen_string_literal: true

module Spree
  Variant.class_eval do
    alias_method :orig_price_in, :price_in
    def price_in(currency)
      return orig_price_in(currency) unless sale_price.present?
      Spree::Price.new(variant_id: id, amount: sale_price, currency: currency)
    end

    def option_value(opt_name, value_name = :presentation)
      option_values.detect { |o| o.option_type.name == opt_name }.try(value_name)
    end
  end
end

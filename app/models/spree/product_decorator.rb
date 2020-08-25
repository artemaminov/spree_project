module Spree
  module ProductDecorator
    def lowest_price_variant
      prices.min_by { |v| v.amount }
    end
  end
end

::Spree::Product.prepend ::Spree::ProductDecorator if ::Spree::Product.included_modules.exclude?(Spree::ProductDecorator)
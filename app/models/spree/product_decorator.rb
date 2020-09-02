module Spree
  Product.class_eval do
    acts_as_list
  end

  module ProductDecorator


    def lowest_price_variant
      prices.min_by { |v| v.amount }
    end

    def taxon_to_return_to
      taxons.first
    end
  end
end

::Spree::Product.prepend ::Spree::ProductDecorator if ::Spree::Product.included_modules.exclude?(Spree::ProductDecorator)

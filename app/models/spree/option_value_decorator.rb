module Spree
  module OptionValueDecorator
    def self.prepended(base)
      base.default_scope { order(:position) }
    end

    def dimension
      "#{width}x#{height}x#{depth}"
    end
  end
end

::Spree::OptionValue.prepend ::Spree::OptionValueDecorator if ::Spree::OptionValue.included_modules.exclude?(Spree::OptionValueDecorator)

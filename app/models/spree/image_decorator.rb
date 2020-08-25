module Spree
  module ImageDecorator
    module ClassMethods
      def styles
        {
            mini:    '49x49>',
            small:   '309x381>',
            product: '538x519>',
            large:   '800x800>',
        }
      end
    end

    def self.prepended(base)
      base.inheritance_column = nil
      base.singleton_class.prepend ClassMethods
    end
  end
end

::Spree::Image.prepend Spree::ImageDecorator if ::Spree::Image.included_modules.exclude?(Spree::ImageDecorator)

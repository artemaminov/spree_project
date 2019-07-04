module Spree
  class SharedImage < Asset
    include Spree::Image::Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    def self.styles
      @styles ||= {
        mini: '48x48>',
        small: '100x100>',
        news_small: '200x200',
        product: '240x240>',
        large: '600x600>',
        news_standard: '500x300',
        news_large: '783x365'
      }
    end

    def styles
      self.class.styles.map do |_, size|
        width, height = size[/(\d+)x(\d+)/].split('x')

        {
          url: polymorphic_path(attachment.variant(resize: size), only_path: true),
          width: width,
          height: height
        }
      end
    end
  end
end
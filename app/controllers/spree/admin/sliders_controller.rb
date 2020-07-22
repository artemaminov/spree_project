module Spree
  module Admin
    class SlidersController < ResourceController
      def new
        @slider.slides.build
        super
      end
    end
  end
end

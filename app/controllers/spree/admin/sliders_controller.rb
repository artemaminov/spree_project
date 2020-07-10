module Spree
  module Admin
    class SlidersController < ResourceController

      def translate
        slider = Spree::Slider.find(params[:id])
        slider.update update_slider_attributes
        redirect_to spree.admin_sliders_path
      end

      private
      def update_slider_attributes
        params.require(:slider).permit(permitted_params)
      end

      def permitted_params
        [:translations_attributes => [:id, :title, :message, :url, :position],
         :cropped_image_attributes => [:id, :attachment, croppers_attributes: [:id, :x, :y, :width, :height, :name]]]
      end
    end
  end
end

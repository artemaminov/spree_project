module Spree
  module Admin
    class RetailersController < ResourceController

      def create
        if permitted_resource_params[:image]
          @retailer.build_image(attachment: permitted_resource_params.delete(:image))
        end

        super
      end

      def update
        if permitted_resource_params[:image]
          @retailer.create_image(attachment: permitted_resource_params.delete(:image))
        end

        super
      end

      def translate
        retailer = Spree::Retailer.find(params[:id])
        retailer.update update_page_attribute
        redirect_to spree.admin_retailers_path
      end

      private

      def find_resource
        Spree::Retailer.find(params[:id])
      end

      def collection
        params[:q] = {} if params[:q].blank?
        retailers = super.order(created_at: :asc)
        @search = retailers.ransack(params[:q])

        @collection = @search.result.
            page(params[:page]).
            per(params[:per_page])
      end

      def update_page_attribute
        params.require(:retailer).permit(permitted_params)
      end

      def permitted_params
        [:translations_attributes => [:id, :region_name, :name, :address]]
      end
    end
  end
end
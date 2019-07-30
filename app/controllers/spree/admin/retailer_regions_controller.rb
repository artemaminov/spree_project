# frozen_string_literal: true

module Spree
  module Admin
    class RetailerRegionsController < ResourceController
      def translate
        region = Spree::RetailerRegion.find(params[:id])
        region.update update_page_attribute
        redirect_to spree.admin_retailer_regions_path
      end

      private

      def find_resource
        Spree::RetailerRegion.find(params[:id])
      end

      def collection
        params[:q] = {} if params[:q].blank?
        regions = super.order(created_at: :asc)
        @search = regions.ransack(params[:q])

        @collection = @search.result
                             .page(params[:page])
                             .per(params[:per_page])
      end

      def update_page_attribute
        params.require(:retailer_region).permit(permitted_params)
      end

      def permitted_params
        [translations_attributes: %i[id name]]
      end
    end
  end
end

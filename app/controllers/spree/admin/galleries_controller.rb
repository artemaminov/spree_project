# frozen_string_literal: true

module Spree
  module Admin
    class GalleriesController < ResourceController
      def create


        super
      end

      def update
        products = products_params_multiple[:products]

        unless products.nil?
          @gallery.products.destroy_all
          @gallery.products << Spree::Product.find(products.reject(&:empty?))
        end

        params[:gallery].delete(:products)

        super
      end

      def translate
        gallery = Spree::Gallery.find(params[:id])
        gallery.update update_page_attribute
        redirect_to spree.admin_galleries_path
      end

      private

      def find_resource
        Spree::Gallery.find(params[:id])
      end

      def collection
        params[:q] = {} if params[:q].blank?
        news = super.order(created_at: :asc)
        @search = news.ransack(params[:q])

        @collection = @search.result
                              .page(params[:page])
                              .per(params[:per_page])
      end

      def update_page_attribute
        params.require(:gallery).permit(permitted_params)
      end

      def permitted_params
        [translations_attributes: %i[id title subtitle desc]]
      end

      def products_params_multiple
        params[:gallery].permit(products: [])
      end
    end
  end
end

# frozen_string_literal: true

module Spree
  module Admin
    class NewsController < ResourceController
      def create
        if permitted_resource_params[:image]
          @news.build_image(attachment: permitted_resource_params.delete(:image))
        end

        super
      end

      def update
        if permitted_resource_params[:image]
          @news.create_image(attachment: permitted_resource_params.delete(:image))
        end

        super
      end

      def translate
        news = Spree::News.find(params[:id])
        news.update update_page_attribute
        redirect_to spree.admin_news_path
      end

      private

      def find_resource
        Spree::News.find(params[:id])
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
        params.require(:news).permit(permitted_params)
      end

      def permitted_params
        [translations_attributes: %i[id name short_info body]]
      end
    end
  end
end

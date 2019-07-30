# frozen_string_literal: true

module Spree
  module Admin
    class QuestionsController < ResourceController
      private

      def collection
        params[:q] = {} if params[:q].blank?
        news = super.order(created_at: :asc)
        @search = news.ransack(params[:q])

        @collection = @search.result
                             .page(params[:page])
                             .per(params[:per_page])
      end
    end
  end
end

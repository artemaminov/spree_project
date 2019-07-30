# frozen_string_literal: true

module Spree
  module Admin
    class RoleDiscountsController < ResourceController
      private

      def find_resource
        Spree::RoleDiscount.find(params[:id])
      end

      def collection
        params[:q] = {} if params[:q].blank?
        role_discounts = super.order(created_at: :asc)
        @search = role_discounts.ransack(params[:q])

        @collection = @search.result
                             .page(params[:page])
                             .per(params[:per_page])
      end
    end
  end
end

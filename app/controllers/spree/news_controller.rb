# frozen_string_literal: true

module Spree
  class NewsController < StoreController
    before_action :set_pagination_params, only: [:index]
    before_action :get_parent, only: %i[index show]

    def show
      @news = Spree::News.visible.find_by(slug: params[:slug])
    end

    def index
      @total_count = model_collection.count
      @news = model_collection.page(@page).per(@limit)
    end

    private

    def get_parent
      @parent = Spree::Page.find_by(slug: '/news')
    end

    def model_collection
      Spree::News.visible
    end

    def set_pagination_params
      @limit = params[:limit] ? params[:limit].to_i : 10
      @page = params[:page] ? params[:page].to_i : 1
    end
  end
end

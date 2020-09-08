module Spree
  class TaxonsController < Spree::StoreController
    helper 'spree/products'
    require 'uri'

    respond_to :html

    def show
      @taxon = Taxon.friendly.find(params[:id])
      return unless @taxon

      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
      @products = @searcher.retrieve_products.reorder(position: :asc)

      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end

    def by_filter
      @taxon = Taxon.friendly.find(params[:taxon_id])
      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
      @products = @searcher.retrieve_products.reorder(position: :asc)

      url_params = params.permit!.to_h
      # url_params.delete(:)

      @url_params = "?#{params.permit!.to_h.to_query}"

      render 'spree/taxons/products_render'
    end

    private

    def accurate_title
      @taxon.try(:seo_title) || super
    end
  end
end

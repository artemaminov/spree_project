module Spree
  module ProductsControllerDecorator
    def show
      @variants = @product.variants_including_master.
          spree_base_scopes.
          active(current_currency).
          includes([:option_values, :images])
      @product_properties = @product.product_properties.includes(:property)
      @taxon = params[:taxon_id].present? ? Spree::Taxon.find(params[:taxon_id]) : @product.taxons.first
      redirect_if_legacy_path

      respond_to do |format|
        format.html
        format.js
      end
    end

    def send_collection
      respond_to do |format|
        format.js {
          byebug
          variant_ids = params[:calc_item].keys
          variants = Spree::Variant.find(variant_ids)
        }
      end
    end

  end
end

::Spree::ProductsController.prepend Spree::ProductsControllerDecorator if ::Spree::ProductsController.included_modules.exclude? Spree::ProductsControllerDecorator
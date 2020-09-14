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
      # {"utf8"=>"✓", "calc_item"=>{"104"=>"4", "105"=>"", "108"=>"4"}, "state"=>{"104"=>"WY", "105"=>"AL", "108"=>"AL"}, "customer_name"=>"Фывапва", "customer_phone"=>"433456456456", "politics_agreement"=>"on", "commit"=>"Отправить заказ"}
      # WY - sqr meters
      # AL - pieces
      respond_to do |format|
        format.js do
          if mail_params[:politics_agreement]
            @calc = mail_params[:calc_item].reject { |k,v| v.blank? }
            @taxon = Spree::Taxon.find mail_params[:taxon]
            OrderMailer.add_collection_email(@calc, @taxon.name, mail_params[:customer]).deliver_later
          end
        end
      end
    end

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products.order(position: :asc)
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end

    private

    def mail_params
      params.permit({ calc_item: {} }, { state: {} }, { customer: [:name, :phone] }, :taxon, :politics_agreement)
    end

  end
end

::Spree::ProductsController.prepend Spree::ProductsControllerDecorator if ::Spree::ProductsController.included_modules.exclude? Spree::ProductsControllerDecorator

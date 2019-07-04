Spree::HomeController.class_eval do
  def index
    @searcher = build_searcher(params.merge(include_images: true))
    @products = @searcher.retrieve_products
    @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @retailers = collected_retailers_info
    @standard_news = news_collection
    @latest_news = @standard_news.latest
  end

  private

    def news_collection
      Spree::News.visible
    end

    def collected_retailers_info
      retailers = Spree::Retailer.enabled
      retailers.collect do |retailer|
        retailer_info = retailer.slice(
            :id, :name, :lat, :lng, :region, :web_site, :address, :phone, :active_on_home, :email
        )
        retailer_info[:image] = retailer.image ? main_app.url_for(retailer.image.url(:small)) : nil
        retailer_info
      end
    end
end
class Spree::PortfolioController < Spree::StoreController
  def index
    @portfolio = Spree::Gallery
                     .all
                     .order(position: :asc)
                     .page(params[:page])
                     .per(10)

    @use_light_nav_bar = true
  end

  def show
    @portfolio = Spree::Gallery.find params[:id]
    @next_portfolio = Spree::Gallery
                          .where('position >= ?', @portfolio.position)
                          .where.not(id: @portfolio.id)
                          .order(position: :asc)
                          .first
  end

end

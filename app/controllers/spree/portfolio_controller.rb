class Spree::PortfolioController < Spree::StoreController
  def index
    @portfolio = Spree::Gallery.all
                         .order(position: :asc)
                         .page(params[:page])
    @use_light_nav_bar = true
  end

  def show
    @portfolio = Spree::Gallery.find params[:id]
    @next_portfolio = @portfolio.next
  end

end

class Spree::PortfolioController < Spree::StoreController
  def index
    @portfolio = Spree::Gallery.all.page(params[:page]).order(position: :asc)
  end

  def show
    @portfolio = Spree::Gallery.find params[:id]
    @next_portfolio = @portfolio.next
  end

end

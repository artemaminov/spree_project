class Spree::PortfolioController < Spree::StoreController
  def index
    @portfolio = Spree::Gallery.all
  end

  def show
    @portfolio = Spree::Gallery.find params[:id]
  end
end

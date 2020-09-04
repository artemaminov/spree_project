class Spree::PortfolioController < Spree::StoreController
  def index
    @portfolio = Spree::Gallery.all
                         .order(position: :asc)
                         .page(params[:page])
  end

  def show
    @portfolio = Spree::Gallery.find params[:id]
    @next_portfolio = @portfolio.next
  end

end

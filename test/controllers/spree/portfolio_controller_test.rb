require 'test_helper'

class Spree::PortfolioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get spree_portfolio_index_url
    assert_response :success
  end

  test "should get show" do
    get spree_portfolio_show_url
    assert_response :success
  end

end

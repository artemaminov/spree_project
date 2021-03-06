# frozen_string_literal: true

Spree::StoreController.class_eval do
  include Rails.application.routes.url_helpers
  include CheckoutHelper

  before_action :load_data

  def load_data
    @slider = Spree::Slider.for_page controller_name, params[:id]
    @page_sections = Spree::PageSection
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @portfolio_sidebar = Spree::Gallery.all.order(position: :asc).limit(5)
  end

  def render_error_message (error)
    status = { status: bad_request }

    case error.class
    when String
      { error: error }.merge(status)
    when Hash
      eror.merge(status)
    else
      { error: error }.merge(status)
    end
  end

  def render_success_message (success)
    status = { status: status_ok }

    case success.class
    when String
      { success: success }.merge(status)
    when Hash
      success.merge(status)
    else
      { success: success }.merge(status)
    end
  end

  def status_ok
    200
  end

  def bad_request
    400
  end
end

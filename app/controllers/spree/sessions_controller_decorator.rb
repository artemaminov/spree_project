Spree::UserSessionsController.class_eval do
  helper 'spree/base'

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::Store

  if defined?(SpreeI18n::ControllerLocaleHelper)
    include SpreeI18n::ControllerLocaleHelper
  end

  def create
    sign_in_by_params

    if spree_user_signed_in?
      respond_to do |format|
        format.html {
          flash[:success] = Spree.t(:logged_in_succesfully)
          redirect_back_or_default(after_sign_in_path_for(spree_current_user))
        }
        format.js {
          render json: { user: spree_current_user,
                         ship_address: spree_current_user.ship_address,
                         bill_address: spree_current_user.bill_address }.to_json
        }
      end
    else
      respond_to do |format|
        format.html {
          flash.now[:error] = t('devise.failure.invalid')
          render :new
        }
        format.js {
          render json: { error: t('devise.failure.invalid') }, status: :unprocessable_entity
        }
      end
    end
  end

  protected

  def translation_scope
    'devise.user_sessions'
  end

  def sanitized_params
    params[:spree_user]
  end

  def sign_in_by_params
    password = sanitized_params[:password]
    user = Spree::User.find_for_database_authentication sanitized_params

    if (user && user.valid_password?(password))
      sign_in user, store: false
    end
  end

  private

  def accurate_title
    Spree.t(:login)
  end

  def redirect_back_or_default(default)
    redirect_to(session["spree_user_return_to"] || default)
    session["spree_user_return_to"] = nil
  end
end
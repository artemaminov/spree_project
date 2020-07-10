# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  mount Spree::Core::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  Spree::Core::Engine.add_routes do
    namespace :admin, path: Spree.admin_path do
      resources :retailers do
        patch :translate, on: :member
      end

      resources :news do
        patch :translate, on: :member
      end

      resources :retailer_regions do
        patch :translate, on: :member
      end

      resources :questions
      resources :role_discounts

      resources :page_sections
      resources :sliders
    end

    resources :news, only: [:index]
    resources :questions, only: [:create]

    get '/news/post/:slug', to: 'news#show', as: :news_post
    delete 'admin/delete_attachment/:attachment_id', to: 'admin/attachments#destroy', as: :delete_attachment

    get '/activations', to: 'user_activations#index', as: :activations
    post '/activations/send_email', to: 'user_activations#send_email', as: :send_activation_email
    post '/activations/check_email', to: 'user_activations#check_email', as: :check_email
    post '/activations/check_phone_number', to: 'user_activations#check_phone_number', as: :check_phone_number

  end
end

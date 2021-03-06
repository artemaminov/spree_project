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

      resources :galleries do
        collection do
          post :update_images_position
          post :update_positions
        end
      end


      resources :products do
        collection do
          post :update_positions
        end
        resources :product_properties do
          collection do
            post :update_positions
          end
        end
        resources :images do
          collection do
            post :update_positions
          end
        end
        member do
          post :clone
          get :stock
        end
        resources :variants do
          collection do
            post :update_positions
          end
        end
        resources :variants_including_master, only: [:update]
      end

      delete 'galleries/file_upload', to: 'galleries#file_upload'
      post 'galleries/file_upload', to: 'galleries#file_upload'

      resources :sliders
      resources :slides
    end

    resources :news, only: [:index]
    resources :questions, only: [:create]
    resources :portfolio, only: [:index, :show]

    get '/news/post/:slug', to: 'news#show', as: :news_post
    delete 'admin/delete_attachment/:attachment_id', to: 'admin/attachments#destroy', as: :delete_attachment

    get '/activations', to: 'user_activations#index', as: :activations
    post '/activations/send_email', to: 'user_activations#send_email', as: :send_activation_email
    post '/activations/check_email', to: 'user_activations#check_email', as: :check_email
    post '/activations/check_phone_number', to: 'user_activations#check_phone_number', as: :check_phone_number

    get '/confidential_agreement', to: 'agreements#confidential_agreement'
    get '/user_agreement', to: 'agreements#user_agreement'
    get '/oferta', to: 'agreements#oferta'

    get '/taxons_by_filter', to: 'taxons#by_filter'
    post '/send_collection', to: 'products#send_collection'
  end
end

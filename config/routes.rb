Rails.application.routes.draw do

	mount Spree::Core::Engine, at: '/'

	Spree::Core::Engine.add_routes do
		namespace :admin, path: Spree.admin_path do
			resources :users do
				member do
					get :seller
					put :seller					
				end
				resources :deliveries						
			end

			resources :product_imports, only: [:index] do
		      collection do
		        delete :reset
		        post :preparse
		        post :import
		      end
		    end			
		end
	end
end

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
		        get :sample_import
		        post :sample_csv_import
		        post :user_csv_import
		        get :download_sample_csv
		        post :shopify_csv_import
		        get :download_sample_shopify_export_csv
		      end
		    end
			
		end
	end
end
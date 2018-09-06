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
			
		end
	end
end
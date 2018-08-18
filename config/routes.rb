Rails.application.routes.draw do

	mount Spree::Core::Engine, at: '/'

	Spree::Core::Engine.add_routes do
		namespace :admin do
			resources :users do
				member do
					get :seller
					put :seller
				end			
			end    
		end
	end
end
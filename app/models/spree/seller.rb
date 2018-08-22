class Spree::Seller <  Spree::Base

 	belongs_to :user, class_name: Spree.user_class.to_s, optional: true

	def self.default(user = nil)
	    if user && user.seller
	    else
	     new(company_name: '')
	    end	
	end
end
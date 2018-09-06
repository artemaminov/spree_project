class Spree::Seller <  Spree::Base

 	belongs_to :user, class_name: Spree.user_class.to_s, optional: true
 	
 	has_many :deliveries
	has_many :deliveries_addresses, :through => :deliveries, class_name: 'Spree::Address', foreign_key: :address_id

	def self.default(user = nil)
	    if user && user.seller
	    else
	     new(company_name: '')
	    end	
	end
end
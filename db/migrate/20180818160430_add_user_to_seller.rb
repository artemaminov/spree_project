class AddUserToSeller < ActiveRecord::Migration[5.1]
  def change
    add_reference :spree_sellers, :spree_users, foreign_key: true
  end
end

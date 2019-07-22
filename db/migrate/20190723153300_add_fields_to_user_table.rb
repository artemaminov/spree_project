# frozen_string_literal: true

class AddFieldsToUserTable < ActiveRecord::Migration[5.2]
  def change
    # add_column :spree_users, :user_type, :string, default: 'private'
    add_column :spree_users, :name, :string
    # add_column :spree_users, :type, :string, default: 'organization'
    add_column :spree_users, :contact_person, :string
    add_column :spree_users, :phone_number, :string
    add_column :spree_users, :legal_address, :string
    add_column :spree_users, :bank_bik, :decimal, precision: 9, scale: 0
    add_column :spree_users, :bank_name, :string
    add_column :spree_users, :checking_account, :decimal, precision: 20, scale: 0
    add_column :spree_users, :correspondent_account, :decimal, precision: 20, scale: 0
    add_column :spree_users, :inn, :decimal, precision: 12, scale: 0
    add_column :spree_users, :bank_kpp, :decimal, precision: 12, scale: 0
    add_column :spree_users, :bank_okdp, :string
    add_column :spree_users, :bank_okpo, :string
    add_column :spree_users, :bank_okonh, :string
    add_column :spree_users, :web_site, :string
    add_column :spree_users, :want_be_dealer, :boolean, default: false
    add_column :spree_users, :phone_number_confirmed, :boolean, default: false
  end
end

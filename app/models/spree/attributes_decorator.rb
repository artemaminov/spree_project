# frozen_string_literal: true

Spree::PermittedAttributes.class_eval do
  class_variable_set(:@@user_attributes,
    class_variable_get(:@@user_attributes).push(
      :phone_number, :contact_person, :legal_address, :bank_name, :bank_bik, :checking_account, :correspondent_account,
      :inn, :bank_kpp, :bank_okdp, :bank_okpo, :bank_okonh, :web_site, :want_be_dealer, :phone_number_confirmed, :name,
      :user_type, :user_organization_type
    )
  )
end

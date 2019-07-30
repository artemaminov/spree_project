# frozen_string_literal: true

# fields: name, phone_number, contact_person, email, legal_address, bank_name, bank_bik,
# checking_account, correspondent_account, inn, bank_kpp, bank_okdp, bank_okpo, bank_okonh,
# web_site, want_be_dealer, phone_number_confirmed

module Spree
  User.class_eval do
    enum user_type: {
        private_user: 'private_user',
        entity_user: 'entity_user'
    }

    enum user_organization_type: {
        organization: 'organization',
        individual: 'individual'
    }

    validates :name, presence: true

    validates :legal_address, :bank_name, presence: true, if: :is_entity_user?

    validates :phone_number, presence: true, numericality: true, length: { is: 11 }, if: :is_entity_user?

    validates :bank_bik, :bank_kpp, presence: true, numericality: true, length: { is: 9 }, if: :is_entity_user?

    validates :checking_account, presence: true, numericality: true, length: { is: 20 }, if: :is_entity_user?

    validates :correspondent_account, presence: true, numericality: true, length: { maximum: 20 }, if: :is_entity_user?


    validates :inn, presence: true, numericality: true, length: { minimum: 10, maximum: 12 }, if: :is_entity_user?

    def is_entity_user?
      user_type == 'entity_user'
    end
  end
end

# frozen_string_literal: true

module Spree
  User.class_eval do
    def self.find_for_database_authentication(warden_conditions)
      where(phone_number: warden_conditions[:email]).or(where(email: warden_conditions[:email])).first
    end

  end
end

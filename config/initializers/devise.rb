# frozen_string_literal: true

Devise.secret_key = 'a1cb0e9bee716d89935b31acdf6d2a36782f9596983ca1f1f990b9e323f4611188c167183043d6bf2dabb7a77fd718f98e9a'

Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 2.days

  # Fixes the bug where Confirmation errors result in a broken page.
  config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.
  config.confirm_within = 2.days
end
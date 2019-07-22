# frozen_string_literal: true

class AddTranslationToRetailer < SpreeExtension::Migration[4.2]
  def up
    unless table_exists?(:spree_retailer_translations)
      params = { region: :string, name: :string, address: :text }
      Spree::Retailer.create_translation_table!(params, migrate_data: true)
    end
  end

  def down
    Spree::Retailer.drop_translation_table! migrate_data: false
  end
end

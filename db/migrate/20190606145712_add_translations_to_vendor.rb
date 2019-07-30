# frozen_string_literal: true

class AddTranslationsToVendor < SpreeExtension::Migration[4.2]
  def up
    unless table_exists?(:spree_vendor_translations)
      params = { name: :string, slug: :string }
      Spree::Vendor.create_translation_table!(params, migrate_data: true)
    end
  end

  def down
    Spree::Vendor.drop_translation_table! migrate_data: true
  end
  end

class AddTranslationToSpreeRetailerRegions < SpreeExtension::Migration[4.2]
  def up
    unless table_exists?(:spree_retailer_region_translations)
      Spree::RetailerRegion.create_translation_table!({ name: :string }, { migrate_data: true })
    end
  end

  def down
    Spree::RetailerRegion.drop_translation_table! migrate_data: false
  end
end
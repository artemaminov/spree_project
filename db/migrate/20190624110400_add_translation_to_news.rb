# frozen_string_literal: true

class AddTranslationToNews < SpreeExtension::Migration[4.2]
  def up
    unless table_exists?(:spree_news_translations)
      params = {
        name: :string,
        short_info: { type: :string, limit: 300 },
        body: :text,
        meta_title: :string,
        meta_description: :string,
        meta_keywords: :string
      }
      Spree::News.create_translation_table!(params, migrate_data: true)
    end
  end

  def down
    Spree::News.drop_translation_table! migrate_data: false
  end
end

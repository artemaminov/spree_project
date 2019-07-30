# frozen_string_literal: true

# This migration comes from spree_static_content (originally 20170827000002)
class AddLayoutToTranslatableFields < SpreeExtension::Migration[4.2]
  def up
    if defined?(SpreeGlobalize)
      Spree::Page.add_translation_fields! layout: :string
    end
  end

  def down
    remove_column :spree_page_translations, :layout if defined?(SpreeGlobalize)
  end
end

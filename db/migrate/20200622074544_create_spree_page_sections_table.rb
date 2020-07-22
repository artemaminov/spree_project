class CreateSpreePageSectionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_page_sections do |t|
      t.string :button_url
      t.string :html_section_name
      t.string :button_style
      t.boolean :button_centered
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Spree::PageSection.create_translation_table! title: :string, description: :text, button_text: :string
      end

      dir.down do
        Spree::PageSection.drop_translation_table!
      end
    end
  end
end


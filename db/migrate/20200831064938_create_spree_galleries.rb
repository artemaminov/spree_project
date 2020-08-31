class CreateSpreeGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_galleries do |t|
      # t.string :title
      # t.string :subtitle
      # t.text :desc

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Spree::Gallery.create_translation_table! title: :string, subtitle: :string, desc: :text
      end

      dir.down do
        Spree::Gallery.drop_translation_table!
      end
    end
  end


end

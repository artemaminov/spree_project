class CreateSlidesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_slides do |t|
      t.integer :order, default: 0
      t.string :url
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Spree::Slide.create_translation_table! title: :string, message: :text
      end

      dir.down do
        Spree::Slide.drop_translation_table!
      end
    end
  end
end

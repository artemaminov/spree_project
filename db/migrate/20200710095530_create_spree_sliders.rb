class CreateSpreeSliders < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_sliders do |t|
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Spree::Slider.create_translation_table! position: :integer, url: :string, title: :string, message: :text
      end

      dir.down do
        Spree::Slider.drop_translation_table!
      end
    end
  end
end

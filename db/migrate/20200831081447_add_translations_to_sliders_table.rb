class AddTranslationsToSlidersTable < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        params = { :name => :string }
        Spree::Slider.create_translation_table!(params)
      end

      dir.down do
        Spree::Slider.drop_translation_table!
      end
    end
  end
end

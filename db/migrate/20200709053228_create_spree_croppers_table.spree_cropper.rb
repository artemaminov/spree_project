# This migration comes from spree_cropper (originally 20200625100155)
class CreateSpreeCroppersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_croppers do |t|
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Spree::Cropper.create_translation_table! cropped_image: :integer, name: :string, x: :integer, y: :integer, width: :integer, height: :integer , variant_key: :string
      end

      dir.down do
        Spree::Cropper.drop_translation_table!
      end
    end
  end
end

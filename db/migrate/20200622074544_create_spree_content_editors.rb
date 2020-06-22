class CreateSpreeContentEditors < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_content_editors do |t|
      t.string :title
      t.text :description
      t.string :button_title
      t.string :button_url
      t.references :spree_asset, foreign_key: true
      t.string :section_to_paste_after

      t.timestamps
    end
  end
end

class CreateSpreeSliders < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_sliders do |t|
      t.string :page
      t.integer :page_id
      t.timestamps
    end
  end
end

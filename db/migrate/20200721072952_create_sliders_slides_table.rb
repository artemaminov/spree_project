class CreateSlidersSlidesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_sliders_slides do |t|
      t.references :slider, foreign_key: { to_table: :spree_sliders }
      t.references :slide, foreign_key: { to_table: :spree_slides }
    end
  end
end

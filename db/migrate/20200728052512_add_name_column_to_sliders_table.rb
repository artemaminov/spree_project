class AddNameColumnToSlidersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_sliders, :name, :string, null: false, default: 'Слайдер'
  end
end

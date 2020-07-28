class AddNameColumnToPageSectionsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_page_sections, :name, :string, null: false, default: 'Блок'
  end
end

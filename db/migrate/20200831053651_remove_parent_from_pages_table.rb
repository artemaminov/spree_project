class RemoveParentFromPagesTable < ActiveRecord::Migration[5.2]
  def change
    change_table :spree_pages do |t|
      t.remove :parent_position
      t.remove :parent_id
    end
  end
end

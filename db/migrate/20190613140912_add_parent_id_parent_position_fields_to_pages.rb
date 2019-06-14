class AddParentIdParentPositionFieldsToPages < SpreeExtension::Migration[4.2]

  def self.up
    change_table :spree_pages do |t|
      t.integer :parent_position, default: 0, null: false
      t.integer :parent_id, default: nil, null: true
    end
  end

  def self.down
    change_table :spree_pages do |t|
      t.remove :parent_position
      t.remove :parent_id
    end
  end

end
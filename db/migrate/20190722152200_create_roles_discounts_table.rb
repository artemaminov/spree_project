# frozen_string_literal: true

class CreateRolesDiscountsTable < SpreeExtension::Migration[4.2]
  def self.up
    create_table :spree_role_discounts do |t|
      t.integer :role_id, default: 0, null: false, index: true
      t.decimal :discount, default: 0, precision: 2, scale: 0
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_role_discounts
  end
end

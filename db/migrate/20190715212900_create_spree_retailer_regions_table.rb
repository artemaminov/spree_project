class CreateSpreeRetailerRegionsTable < SpreeExtension::Migration[4.2]
  def self.up
    create_table :spree_retailer_regions do |t|
      t.float :lng, default: 0, null: false
      t.float :lat, default: 0, null: false
      t.string :name, default: '', null: false
      t.boolean :disabled, default: false
      t.boolean :active_on_home, default: false
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_retailer_regions
  end
end
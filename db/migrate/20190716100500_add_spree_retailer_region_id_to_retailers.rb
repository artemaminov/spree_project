class AddSpreeRetailerRegionIdToRetailers < SpreeExtension::Migration[4.2]

  def self.up
    change_table :spree_retailers do |t|
      t.integer :retailer_region_id, default: 0, null: false, index: true
      t.remove :region
      t.remove :active_on_home
    end
  end

  def self.down
    change_table :spree_retailers do |t|
      t.remove :retailer_region_id
      t.string :region, default: '', null: false
      t.boolean :active_on_home, default: true
    end
  end
end

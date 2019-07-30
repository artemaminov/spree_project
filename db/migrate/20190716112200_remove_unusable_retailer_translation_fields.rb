# frozen_string_literal: true

class RemoveUnusableRetailerTranslationFields < SpreeExtension::Migration[4.2]
  def self.up
    change_table :spree_retailer_translations do |t|
      t.remove :region
    end
  end

  def self.down
    change_table :spree_retailer_translations do |t|
      t.string :region, default: ''
    end
  end
end

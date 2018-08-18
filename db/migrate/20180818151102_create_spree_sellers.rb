class CreateSpreeSellers < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_sellers do |t|	
      t.string :name
	  t.text :company_name
	  t.string :company_inn
	  t.text :company_address
	  t.text :company_rs
	  t.text :company_bank
	  t.text :company_kors
      t.timestamps
    end
  end
end

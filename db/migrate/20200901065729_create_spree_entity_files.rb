class CreateSpreeEntityFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_entity_files do |t|
      t.string :entity
      t.string :name
      t.integer :file_id

      t.timestamps
    end
  end
end

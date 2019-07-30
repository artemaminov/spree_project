# frozen_string_literal: true

class CreateFileAttachmentTable < SpreeExtension::Migration[4.2]
  def self.up
    create_table :spree_file_attachments do |t|
      t.string :name, default: '', null: false
      t.integer :page_id, default: 0, null: false, index: true
      t.datetime :published_at
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_file_attachments
  end
end

class CreateSpreeNewsTable < SpreeExtension::Migration[4.2]
  def self.up
    create_table :spree_news do |t|
      t.string :name, default: '', null: false
      t.string :short_info, default: '', limit: 300
      t.text :body, default: ''
      t.boolean :show_on_site, default: true
      t.boolean :latest, default: true
      t.datetime :publication_date, default: Time.now
      t.string :meta_title, default: ''
      t.string :meta_description, default: ''
      t.string :meta_keywords, default: ''
      t.string :slug, null: false, default: '', unique: true
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_news
  end
end
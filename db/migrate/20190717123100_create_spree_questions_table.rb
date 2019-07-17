class CreateSpreeQuestionsTable < SpreeExtension::Migration[4.2]
  def self.up
    create_table :spree_questions do |t|
      t.string :name, default: '', null: false
      t.string :phone, default: '', null: false
      t.boolean :email_send, default: false
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_questions
  end
end
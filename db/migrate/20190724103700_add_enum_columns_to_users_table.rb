# frozen_string_literal: true

class AddEnumColumnsToUsersTable < SpreeExtension::Migration[4.2]
  def up
    ActiveRecord::Base.connection.execute <<~SQL
      CREATE TYPE spree_user_type AS ENUM ('private_user', 'entity_user');
      CREATE TYPE spree_user_organization_type AS ENUM ('organization', 'individual');
    SQL

    add_column :spree_users, :user_type, :spree_user_type, index: true, default: 'private_user'
    add_column :spree_users, :user_organization_type, :spree_user_organization_type, index: true, default: 'organization'
  end

  def down
    remove_column :spree_users, :user_type
    remove_column :spree_users, :user_organization_type

    ActiveRecord::Base.connection.execute <<~SQL
      DROP TYPE spree_user_type;
      DROP TYPE spree_user_organization_type;
    SQL
  end
end

class ChangeUserIdToUuid < ActiveRecord::Migration[7.2]
  class ChangeUserIdToUuid < ActiveRecord::Migration[7.2]
    def change
      enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  
      add_column :users, :uuid, :uuid, default: 'gen_random_uuid()', null: false
      remove_column :users, :id
      rename_column :users, :uuid, :id
  
      execute 'ALTER TABLE users ADD PRIMARY KEY (id);'
    end
  end
end

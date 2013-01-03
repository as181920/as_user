class AddIndexToNameAndAddNicknameToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string, limit: 100
    add_index :users, :name, unique: true
  end
end

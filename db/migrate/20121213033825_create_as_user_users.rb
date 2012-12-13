class CreateAsUserUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, limit: 100
      t.string :password_digest, limit: 60

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end

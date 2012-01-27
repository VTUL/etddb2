class AddDeviseToPeople< ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.remove :email

      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
    end

    add_index :people, :pid,                  :unique => true
    add_index :people, :email,                :unique => true
    add_index :people, :reset_password_token, :unique => true
    # add_index :people, :confirmation_token,   :unique => true
    # add_index :people, :unlock_token,         :unique => true
    # add_index :people, :authentication_token, :unique => true
  end

  def self.down
    remove_index :people, :pid
    remove_index :people, :email
    remove_column :people, :database_authenticatable
    remove_column :people, :recoverable
    remove_column :people, :rememberable
    remove_column :people, :trackable
    remove_column :people, :reset_password_token
  end
end

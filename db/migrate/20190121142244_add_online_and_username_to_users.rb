class AddOnlineAndUsernameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :online, :integer, default: false
    add_column :users, :username, :string
  end
end

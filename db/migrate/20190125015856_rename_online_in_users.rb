class RenameOnlineInUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :online, :signed_in
  end
end

class ChangeSignedInToBooleanInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :signed_in, nil
    change_column :users, :signed_in, 'boolean USING CAST(signed_in AS boolean)'
  end
end

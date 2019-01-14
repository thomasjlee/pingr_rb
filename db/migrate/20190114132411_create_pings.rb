class CreatePings < ActiveRecord::Migration[5.2]
  def change
    create_table :pings do |t|
      t.integer :pinger_id, null: false
      t.integer :recipient_id, null: false
      t.datetime :read_at
      t.datetime :created_at, null: false
    end
  end
end

class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.string :entity_type
      t.integer :entity_id
      t.decimal :balance
      t.string :account_number, null: false, limit: 10 

      t.timestamps
    end
  end
end

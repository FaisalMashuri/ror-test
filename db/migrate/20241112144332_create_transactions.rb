class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.string :source_wallet_account
      t.string :target_wallet_account
      t.decimal :amount
      t.string :transaction_type

      t.timestamps
    end
  end
end

class Wallet < ApplicationRecord
    self.inheritance_column = :entity_type

    validates :balance, numericality: { greater_than_or_equal_to: 0 }
    validates :account_number, presence: true, numericality: { only_integer: true }, length: { is: 10 }
  
    def deposit(amount)
      self.balance += amount
      save!
    end
  
    def withdraw(amount)
      self.balance -= amount
      save!
    end
end


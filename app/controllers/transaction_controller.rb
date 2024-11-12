class TransactionController < ApplicationController
  def deposit
    @amount = params[:amount].to_f
    @target_wallet_account = params[:target_wallet_account]

    @target_wallet = Wallet.find_by(account_number: @target_wallet_account)

    if @target_wallet.nil?
      @response = BaseDto.new(status: 'error', message: 'wallet not found', data: nil)
      return render json: @response.as_json, status: :ok
    end

    ActiveRecord::Base.transaction do
      transaction = Transaction.create!(
      amount:@amount,
      transaction_type: "deposit",
      target_wallet_account: @target_wallet.account_number
    )

    @target_wallet.deposit(@amount)
    @response = BaseDto.new(status: 'success', message: 'Deposit successfully', data: nil)
      return render json: @response.as_json, status: :ok
    end

    
  end

  def withdraw
    @amount = params[:amount].to_f
    @source_wallet_account = params[:source_wallet_account]

    @source_wallet = Wallet.find_by(account_number: @source_wallet_account)

    if @source_wallet.nil?
      @response = BaseDto.new(status: 'error', message: 'wallet not found', data: nil)
      return render json: @response.as_json, status: :ok
    end

    if @source_wallet.balance < @amount || @amount < 0 || @source_wallet.balance == 0
      @response = BaseDto.new(status: 'error', message: 'Insufficient funds', data: nil)
      return render json: @response.as_json, status: :ok
    end

    ActiveRecord::Base.transaction do
      transaction = Transaction.create!(
      amount:@amount,
      transaction_type: "withdraw",
      source_wallet_account: @source_wallet.account_number
      )

      @source_wallet.withdraw(@amount)
      @response = BaseDto.new(status: 'success', message: 'Withdraw successfully', data: nil)
      return render json: @response.as_json, status: :ok
    end
  end

  def transfer
    @amount = params[:amount].to_f
    @target_wallet_account = params[:target_wallet_account]
    @source_wallet_account = params[:source_wallet_account]
  
    # Fetch source and target wallets based on account numbers
    @source_wallet = Wallet.find_by(account_number: @source_wallet_account)
    @target_wallet = Wallet.find_by(account_number: @target_wallet_account)
  
    # Check if source wallet and target wallet exist
    if @source_wallet.nil? || @target_wallet.nil?
      @response = BaseDto.new(status: 'error', message: 'Invalid wallet account(s)', data: nil)
      return render json: @response.as_json, status: :ok
    end
  
    # Ensure source wallet has sufficient balance
    if @source_wallet.balance < @amount || @amount <= 0
      @response = BaseDto.new(status: 'error', message: 'Insufficient funds', data: nil)
      return render json: @response.as_json, status: :ok
    end
  
    # Begin database transaction to ensure data integrity
    ActiveRecord::Base.transaction do
      # Withdraw from source wallet and deposit to target wallet
      @source_wallet.withdraw(@amount)
      @target_wallet.deposit(@amount)
  
      # After updating wallets, create the transaction record
      transaction = Transaction.create!(
        amount: @amount,
        transaction_type: "debit",
        source_wallet_account: @source_wallet.account_number,
        target_wallet_account: @target_wallet.account_number
      )
  
      # Return success response after the transaction is successful
      @response = BaseDto.new(status: 'success', message: 'Debit successful', data: nil)
      return render json: @response.as_json, status: :ok
    end
  end
end

require_relative('../db/sql_runner.rb')

class Wallet

  attr_reader :id, :wallet_amount

  def initialize(options)
    @id = options['id'].to_i
    @wallet_amount = options['wallet_amount'].to_i
  end

  def save
    sql = "INSERT INTO wallets(
      wallet_amount
    )
    VALUES(
      $1
    )
      RETURNING *"
    values = [@wallet_amount]
    wallet_data = SqlRunner.run(sql, values)
    @id = wallet_data[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM wallets"
    values = []
    wallet_data = SqlRunner.run(sql, values)
    result = wallet_data.map {|wallet| Wallet.new(wallet)}
  return result
  end

  def return_name
    return @wallet_amount
  end

end

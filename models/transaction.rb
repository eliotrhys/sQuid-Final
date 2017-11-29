require_relative('../db/sql_runner.rb')
require_relative('merchant.rb')
require_relative('tag.rb')

class Transaction

  attr_reader :id, :amount, :merchant_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i
    @amount = options['amount']
    @merchant_id = options['merchant_id']
    @tag_id = options['tag_id']
  end

  def save
    sql = "INSERT INTO transactions(
      amount,
      merchant_id,
      tag_id
    )
    VALUES(
      $1, $2, $3
    )
      RETURNING *"
    values = [@amount, @merchant_id, @tag_id]
    transaction_data = SqlRunner.run(sql, values)
    @id = transaction_data[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM transactions ORDER BY id DESC LIMIT 4"
    values = []
    transaction_data = SqlRunner.run(sql, values)
    result = transaction_data.map {|transaction| Transaction.new(transaction)}
    return result
  end

  def merchant
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [@merchant_id]
    results = SqlRunner.run(sql, values)
    final_result = Merchant.new(results[0])
    return final_result
  end

  def tag
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [@tag_id]
    results = SqlRunner.run(sql, values)
    final_result = Tag.new(results[0])
    return final_result
  end

  def self.delete(id)
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run(sql, values)
    result = Transaction.new(transaction[0])
    return result
  end

  def update
    sql = "UPDATE transactions
    SET
    (
      amount,
      merchant_id,
      tag_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@amount, @merchant_id, @tag_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.total_spend()
    sql = "SELECT SUM(amount)
    FROM transactions"
    values = []
    result = SqlRunner.run(sql, values)
    return result[0]['sum']
  end

  def self.by_tag(id)
    sql = "SELECT * FROM transactions
    INNER JOIN tags
    ON transactions.tag_id = tags.id
    WHERE tags.id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    final_result = result.map{|transaction| Transaction.new(transaction)}
    return final_result
  end

  def self.by_merchant(id)
    sql = "SELECT * FROM transactions
    INNER JOIN merchants
    ON transactions.merchant_id = merchants.id
    WHERE merchants.id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    final_result = result.map{|merchant| Merchant.new(merchant)}
    return final_result
  end

  def self.total_spend_by_tag(id)
    sql = "SELECT SUM(amount)
    FROM transactions
    WHERE tag_id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result[0]['sum']
  end

  def self.total_spend_by_merchant(id)
    sql = "SELECT SUM(amount)
    FROM transactions
    WHERE merchant_id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result[0]['sum']
  end

end

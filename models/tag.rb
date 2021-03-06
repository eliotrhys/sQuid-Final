require_relative('../db/sql_runner.rb')

class Tag

  attr_reader :id, :tag

  def initialize(options)
    @id = options['id'].to_i
    @tag = options['tag']
  end

  def save
    sql = "INSERT INTO tags(
      tag
    )
    VALUES(
      $1
    )
      RETURNING *"
    values = [@tag]
    tag_data = SqlRunner.run(sql, values)
    @id = tag_data[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM tags"
    values = []
    tag_data = SqlRunner.run(sql, values)
    result = tag_data.map {|tag| Tag.new(tag)}
    return result
  end

  def return_tag
    return @tag.tag
  end

  def self.delete(id)
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.find(id)
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [id]
    tag = SqlRunner.run(sql, values)
    result = Tag.new(tag[0])
    return result
  end

  def update
    sql = "UPDATE tags
    SET
    (
      tag
    ) =
    (
      $1
    )
    WHERE id = $2"
    values = [@tag, @id]
    SqlRunner.run(sql, values)
  end

end

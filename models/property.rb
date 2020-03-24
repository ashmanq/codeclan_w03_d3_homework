require('pg')

class Property
  attr_accessor :address, :value, :year_built, :no_of_bedrooms
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value']
    @year_built = options['year_built']
    @no_of_bedrooms = options['no_of_bedrooms']
  end

  def save()
    db = PG.connect({dbname: 'properties', host: 'localhost'})

    sql =
    "INSERT INTO properties
      (
        address,
        value,
        year_built,
        no_of_bedrooms
      )
      VALUES
      (
        $1,
        $2,
        $3,
        $4
      )
      RETURNING *;"

      values = [@address, @value, @year_built, @no_of_bedrooms]

      db.prepare("save", sql)

      @id = db.exec_prepared("save", values)[0]["id"].to_i

      db.close()
  end


  def Property.all()
    db = PG.connect({dbname: 'properties', host: 'localhost'})

    sql = "SELECT * from properties"

    db.prepare("all", sql)

    orders = db.exec_prepared("all")
    db.close()

    return orders.map {|order| Property.new(order)}
  end

  def Property.delete_all()
    db = PG.connect({dbname: 'properties', host: 'localhost'})

    sql = "DELETE FROM properties"

    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'properties', host: 'localhost'})

    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]

    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'properties', host: 'localhost'})

    sql = "UPDATE properties
              SET (
                address,
                value,
                year_built,
                no_of_bedrooms
              )
              =
              (
                $1, $2, $3, $4
              )
                WHERE id = $5
          "

    values = [@address, @value, @year_built, @no_of_bedrooms, @id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def Property.find_by_id(id)
    db = PG.connect({dbname: 'properties', host: 'localhost'})

    sql = "SELECT * FROM properties WHERE id = $1"

    values = [id.to_s]

    db.prepare("find_by_id", sql)

    result = db.exec_prepared("find_by_id", values)

    db.close

    return result.map {|property| Property.new(property)}

  end

end

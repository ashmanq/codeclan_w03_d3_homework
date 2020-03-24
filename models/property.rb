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

end

require "pg"

class Specialisation < App
  attr_accessor :specialisation_id, :specialisation_name

  # This class method converts the parsed data into to an instance object of the Specialisation class and returns it.
  def self.hydrate_data specialisation_data
    specialisation = Specialisation.new
    specialisation.specialisation_id = specialisation_data["specialisation_id"].to_i
    specialisation.specialisation_name = specialisation_data["specialisation_name"]

    return specialisation
  end

  # This method queries the db for all the entries in the specialisation_table models the returned data as Specialisation objects using hydrate and maps them to an array.
  def self.all
    conn = self.open_connection

    sql = "SELECT * FROM specialisation_table ORDER BY specialisation_id;"

    results = conn.exec(sql)

    specialisations = results.map do |tuple|
      self.hydrate_data tuple
    end

    return specialisations
  end

  # This class takes the specialisation_id, queries the db and returns an instance object of Specialisation.
  def self.find specialisation_id
    conn = self.open_connection
    sql = "SELECT specialisation_id, specialisation_name FROM specialisation_table WHERE specialisation_id=#{specialisation_id};"

    result = conn.exec(sql).first

    specialisation = self.hydrate_data result

    conn.close

    return specialisation
  end

  def save
    conn = App.open_connection

    if !self.specialisation_id
      sql = "INSERT INTO specialisation_table (specialisation_name) VALUES('#{self.specialisation_name}');"
    else
      sql = "UPDATE specialisation_table SET specialisation_name = '#{self.specialisation_name}' WHERE specialisation_id = #{self.specialisation_id};"
    end

    conn.exec(sql)
  end

  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM specialisation_table WHERE specialisation_id = #{id};"
    conn.exec(sql)
  end

end

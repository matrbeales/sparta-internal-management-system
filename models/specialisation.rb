class Specialisation < App
  attr_accessor :specialisation_id, :specialisation_name

  def self.hydrate_data specialisation_data
    specialisation = Specialisation.new
    specialisation.specialisation_id = specialisation_data["specialisation_id"].to_i
    specialisation.specialisation_name = specialisation_data["specialisation_name"]

    return specialisation
  end

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM specialisation_table ORDER BY specialisation_id;"
    results = conn.exec(sql)

    specialisations = results.map do |tuple|
      self.hydrate_data tuple
    end

    conn.close
    return specialisations
  end

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
    conn.close
  end

  # Checks if the Specialisation is being used by a Cohort. Stops from deleting if it is
  def self.can_destroy? id
    conn = self.open_connection
    sql = "SELECT COUNT(*) FROM cohort_table WHERE specialisation_id = #{id};"
    specialisation_count = conn.exec(sql).first["count"].to_i
    conn.close

    if specialisation_count == 0
      return true
    else
      return false
    end

  end

  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM specialisation_table WHERE specialisation_id = #{id};"
    conn.exec(sql)
    conn.close
  end

end

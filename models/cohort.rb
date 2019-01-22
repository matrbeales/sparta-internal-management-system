require "pg"

class Cohort
  attr_accessor :cohort_id, :cohort_name, :specialisation_id
    def self.open_connection
      return PG.connect(dbname: "user_management", user: "postgres", password: "password")
    end


  def self.hydrate_data cohort_data
    cohort = Cohort.new
    cohort.cohort_id = cohort_data["cohort_id"].to_i
    cohort.cohort_name = cohort_data["cohort_name"]
    cohort.specialisation_id = cohort_data["specialisation_id"].to_i

    return cohort
  end

  def self.all
      conn = self.open_connection

      sql = "SELECT * FROM cohort_table ORDER BY cohort_id;"

      results = conn.exec(sql)

      cohorts = results.map do |tuple|
        self.hydrate_data tuple
      end

      return cohorts
    end

  def self.find cohort_id
    conn = self.open_connection
    sql = "SELECT cohort_id, cohort_name, specialisation_id FROM cohort_table WHERE cohort_id = #{cohort_id};"
    result = conn.exec(sql).first

    cohort = self.hydrate_data result

    conn.close

    return cohort
  end

  def save
    conn = Cohort.open_connection

    if !self.cohort_id
      sql = "INSERT INTO cohort_table (cohort_name, specialisation_id) VALUES('#{self.cohort_name}', #{self.specialisation_id});"
    else
      sql = "UPDATE cohort_table SET cohort_name = '#{self.cohort_name}', specialisation_id = #{self.specialisation_id} WHERE cohort_id = #{self.cohort_id};"
    end

    conn.exec(sql)
  end

  def get_info resource, column, id
    conn = User.open_connection
    sql = "SELECT #{column} FROM #{resource}_table WHERE #{resource}_id = #{id};"
    value = conn.exec(sql)[0]["#{column}"]

    conn.close
    return value
  end

  def self.get_last_id resource
    conn = Cohort.open_connection
    sql = "SELECT #{resource}_id FROM #{resource}_table ORDER BY #{resource}_id DESC LIMIT 1;"
    value = conn.exec(sql)[0]["#{resource}_id"]
    conn.close
    return value
  end

  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM cohort_table WHERE cohort_id = #{id};"
    conn.exec(sql)
  end





end

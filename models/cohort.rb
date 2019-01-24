require "pg"

class Cohort < App
  attr_accessor :cohort_id, :cohort_name, :specialisation_id

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
    conn = App.open_connection

    if !self.cohort_id
      sql = "INSERT INTO cohort_table (cohort_name, specialisation_id) VALUES('#{self.cohort_name}', #{self.specialisation_id});"
    else
      sql = "UPDATE cohort_table SET cohort_name = '#{self.cohort_name}', specialisation_id = #{self.specialisation_id} WHERE cohort_id = #{self.cohort_id};"
    end

    conn.exec(sql)
  end

  def self.can_destroy? id
    conn = self.open_connection
    sql1 = "SELECT COUNT(*) FROM user_table WHERE cohort_id = #{id};"
    cohort_count = conn.exec(sql1).first
    if cohort_count == 0
      return true
    else
      return false
    end
  end

  def self.destroy id
    conn = self.open_connection
    sql2 = "DELETE FROM cohort_table WHERE role_id = #{id};"
    conn.exec(sql2)
  end

end

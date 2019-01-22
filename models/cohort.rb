require "pg"

class Cohort

  def self.find cohort_id
    conn = self.open_connection
    sql = "SELECT cohort_name, cohort_id FROM cohort_table WHERE cohort_id = #{specialisation_id};"
    result = conn.exec(sql).first

    cohort = self.hydrate_data result

    conn.close

    return cohort
  end

  def get_info resource, column, id
    conn = User.open_connection
    sql = "SELECT #{column} FROM #{resource}_table WHERE #{resource}_id = #{id};"
    value = conn.exec(sql)[0]["#{column}"]

    conn.close
    return value
  end








end

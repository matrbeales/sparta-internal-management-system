require "pg"

class Role

  def self.find role_id
    conn = self.open_connection
    sql = "SELECT role_id, role_name FROM role_table WHERE role_id =#{role_id};"
    result = conn.exec(sql).first

    role = self.hydrate_data result

    conn.close

    return role
  end

  def get_info resource, column, id # cohort, cohort_name, cohort_id
    conn = User.open_connection
    sql = "SELECT #{column} FROM #{resource}_table WHERE #{resource}_id = #{id};"
    value = conn.exec(sql)[0]["#{column}"]

    conn.close
    return value
  end

end

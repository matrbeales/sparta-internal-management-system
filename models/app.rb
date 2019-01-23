require "pg"

class App

  def self.open_connection
    return PG.connect(dbname: "user_management", user: "postgres", password: "password")
  end

  def self.get_info resource, column, id # e.g. cohort, cohort_name, cohort_id
    conn = self.open_connection
    sql = "SELECT #{column} FROM #{resource}_table WHERE #{resource}_id = #{id};"
    result = conn.exec(sql)
    conn.close

    if result.ntuples != 0
      value = result[0]["#{column}"]
      return value
    else
      return nil
    end

  end

  def self.get_last_id resource
    conn = self.open_connection
    sql = "SELECT #{resource}_id FROM #{resource}_table ORDER BY #{resource}_id DESC LIMIT 1;"
    value = conn.exec(sql)[0]["#{resource}_id"]
    conn.close
    return value
  end


end

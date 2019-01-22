require "pg"

class Role
  attr_accessor :role_id, :role_name

  def self.open_connection
    return PG.connect(dbname: "user_management", user: "postgres", password: "password")
  end

  def self.hydrate_data role_data
    role = Role.new
    role.role_id = role_data["role_id"].to_i
    role.role_name = role_data["role_name"]
    return role
  end

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM role_table ORDER BY role_id;"
    results = conn.exec(sql)
    roles = results.map do |tuple|
    self.hydrate_data tuple
  end
  return roles
end

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

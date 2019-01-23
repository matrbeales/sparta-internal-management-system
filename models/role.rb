require "pg"

class Role < App
  attr_accessor :role_id, :role_name

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

end

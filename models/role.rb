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

  def self.find role_id
    conn = self.open_connection
    sql = "SELECT role_id, role_name FROM role_table WHERE role_id = #{role_id};"
    result = conn.exec(sql).first
    role = self.hydrate_data result
    conn.close
    return role
  end

  def save
    conn = App.open_connection

    if !self.role_id
      sql = "INSERT INTO role_table (role_name) VALUES('#{self.role_name}');"
    else
      sql = "UPDATE role_table SET  role_name = '#{self.role_name}' WHERE role_id = #{self.role_id};"
    end
    conn.exec(sql)
  end



  def self.get_last_id resource
    conn = Role.open_connection
    sql = "SELECT #{resource}_id FROM #{resource}_table ORDER BY #{resource}_id DESC LIMIT 1;"
    value = conn.exec(sql)[0]["#{resource}_id"]
    conn.close
    return value
  end

  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM role_table WHERE role_id = #{id};"
    conn.exec(sql)
  end

end

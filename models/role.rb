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

    conn.close
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
    conn.close
  end

  # Checks if the Role is being used by a User. Stops from deleting if it is
  def self.can_destroy? id
    conn = self.open_connection
    sql = "SELECT COUNT(*) FROM user_table WHERE role_id = #{id};"
    role_count = conn.exec(sql).first["count"].to_i
    conn.close

    if role_count == 0
      return true
    else
      return false
    end

  end

  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM role_table WHERE role_id = #{id};"
    conn.exec(sql)
    conn.close
  end

end

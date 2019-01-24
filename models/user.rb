class User < App
attr_accessor :user_id, :first_name, :last_name, :email, :password, :cohort_id, :role_id

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM user_table ORDER BY user_id;"
    results = conn.exec(sql)

    users = results.map do |tuple|
      self.hydrate_data tuple
    end

    conn.close
    return users
  end

  def self.hydrate_data user_data
    user = User.new
    user.user_id = user_data["user_id"].to_i
    user.first_name = user_data["first_name"]
    user.last_name = user_data["last_name"]
    user.email = user_data["email"]
    user.password = user_data["password"]
    user.cohort_id = user_data["cohort_id"].to_i
    user.role_id = user_data["role_id"].to_i

    return user
  end

  def self.find user_id
    conn = self.open_connection
    sql = "SELECT user_id, first_name, last_name, email, password, cohort_id, role_id FROM user_table WHERE user_id=#{user_id};"
    result = conn.exec(sql).first
    user = self.hydrate_data result

    conn.close
    return user
  end


  def save
    conn = App.open_connection

    if !self.user_id
      sql = "INSERT INTO user_table (first_name, last_name, email, password, cohort_id, role_id) VALUES('#{self.first_name}', '#{self.last_name}', '#{self.email}', '#{self.password}', #{self.cohort_id}, #{self.role_id});"
    else
      sql = "UPDATE user_table SET first_name = '#{self.first_name}', last_name = '#{self.last_name}', email = '#{self.email}', password = '#{self.password}', cohort_id = #{self.cohort_id}, role_id = #{self.role_id} WHERE user_id = #{self.user_id};"
    end

    conn.exec(sql)
    conn.close
  end


  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM user_table WHERE user_id = #{id};"
    conn.exec(sql)
    conn.close
  end

  
end

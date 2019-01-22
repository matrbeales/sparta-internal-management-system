require "pg"

class User
attr_accessor :user_id, :first_name, :last_name, :email, :password, :cohort_id, :role_id
  def self.open_connection
    return PG.connect(dbname: "user_management", user: "postgres", password: "password")
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

    puts "Result: #{result}"

    user = self.hydrate_data result



    conn.close

    return user
  end

  # def get_info table, id
  #   conn = User.open_connection
  #   sql = "SELECT #{table}_name FROM #{table}_table WHERE #{table}_id = #{id};"
  #   value = conn.exec(sql)[0]["#{table}_name"]
  #
  #   conn.close
  #   return value
  # end


  def get_info resource, column, id # cohort, cohort_name, cohort_id
    conn = User.open_connection
    sql = "SELECT #{column} FROM #{resource}_table WHERE #{resource}_id = #{id};"
    value = conn.exec(sql)[0]["#{column}"]

    conn.close
    return value
  end


end

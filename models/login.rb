class Login < App

  # Checks if email & password match an entry in the database.
  def self.password_match? email, password
    conn = self.open_connection
    sql = "SELECT user_id FROM user_table WHERE email = '#{email}';"
    result = conn.exec(sql)
    conn.close

    if result.ntuples != 0
      user_id = result[0]["user_id"]

      if (App.get_info "user", "password", user_id) == password
        return true
      else
        return false
      end

    else
      return false
    end

  end

end

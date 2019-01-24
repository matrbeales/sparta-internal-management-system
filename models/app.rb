class App

  def self.open_connection
    return PG.connect(dbname: "user_management", user: "postgres", password: "password")
  end

  # Returns the value in <column> from <resource> where <resource_id> = <id>
  # e.g. App.get_info "specialisation", "specialisation_name", @cohort.specialisation_id
  # ^ would return the specialisation name from the specialisation table where the id matches the @cohort.specialisation_id
  def self.get_info resource, column, id
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

  def self.correct_form_entry? *values
    correct = true

    for value in values
      if value.strip == ""
        correct = false
      end

    end

    return correct
  end

  def self.correct_password? password
    if (/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})/ =~ "#{password}") == 0
      return true
    else
      return false
    end
  end


end

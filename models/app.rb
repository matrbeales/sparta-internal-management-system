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

    # Returns result if it exists
    if result.ntuples != 0
      value = result[0]["#{column}"]
      return value
    else
      return nil
    end

  end

  # Gets the id of the last row in the <resource> table
  def self.get_last_id resource
    conn = self.open_connection
    sql = "SELECT #{resource}_id FROM #{resource}_table ORDER BY #{resource}_id DESC LIMIT 1;"
    value = conn.exec(sql)[0]["#{resource}_id"]
    conn.close
    return value
  end

  # Returns false if text entry has no characters in it
  def self.correct_form_entry? *values
    correct = true

    for value in values
      if value.strip == ""
        correct = false
      end

    end

    return correct
  end

  # Returns true if password is >=8 characters long, and has at least 1 number, 1 uppercase letter, and 1 lowercase letter
  def self.correct_password? password
    if (/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})/ =~ "#{password}") == 0
      return true
    else
      return false
    end
  end

  # Counts the number of entries in <table> where <column> = <equivilent>
  def unique_count_new table, column, equivilent
    conn = App.open_connection
    sql = "SELECT COUNT(*) FROM #{table} WHERE #{column} = '#{equivilent}';"
    count = conn.exec(sql).first["count"].to_i
    conn.close

    return count
  end

  # Counts the number of entries in <table> where <column1> = <equivilent>, and <column2> != <not_equivilent>
  def unique_count_edit table, column1, equivilent, column2, not_equivilent
    conn = App.open_connection
    sql = "SELECT COUNT(*) FROM #{table} WHERE #{column1} = '#{equivilent}' AND NOT #{column2} = #{not_equivilent};"
    count = conn.exec(sql).first["count"].to_i
    conn.close

    return count
  end


end

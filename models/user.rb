require "pg"

class User
attr_accessor :user_id, :first_name, :last_name, :email, :password, :cohort_id, :role_id
  def self.open_connection
    return PG.connect(dbname: "user_management")
  end

  

end

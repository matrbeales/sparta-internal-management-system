require "pg"

class User

  def self.open_connection
    return PG.connect(dbname: "user_management")
  end

end

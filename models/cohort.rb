require "pg"

class Cohort
  attr_accessor :cohort_id, :cohort_name, :specialisation_id
    def self.open_connection
      return PG.connect(dbname: "user_management", user: "postgres", password: "password")
    end

    def self.all
        conn = self.open_connection

        sql = "SELECT * FROM cohort_table ORDER BY cohort_id;"

        results = conn.exec(sql)

        cohorts = results.map do |tuple|
          self.hydrate_data tuple
        end

        return cohorts
      end


    def self.hydrate_data cohort_data
      cohort = Cohort.new
      cohort.cohort_id = cohort_data["cohort_id"].to_i
      cohort.cohort_name = cohort_data["cohort_name"]
      cohort.specialisation_id = cohort_data["specialisation_id"].to_i

      return cohort
    end
end

# Sparta-internal-management-system

We were tasked with creating a Internal Management System using the 7 restful routes which we applied to our websites directory system.

In this website application, after logging in, you can Create, Read, Update and Delete Users, their Roles, their Cohorts, and the Specialisation of each Cohort.

You can also send a POST request to /api. If this request has correct email and password keys attached, it will return an authentication token.

# How to use/run the Website Application Locally

1. Clone the repository to your local
2. Manually create the database called user_management then run the seed file:

```
  psql -U postgres
```

```
  CREATE DATABASE user_management
```

```
  \q
```

```
  psql -U postgres -d user_management -f seed.sql
```


3. Run the 'bundle' command to automatically install all the gems/dependencies
4. Run the 'rackup' command on Git bash to run the server

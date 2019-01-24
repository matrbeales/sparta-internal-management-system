class ApiController < AppController

  # INDEX
  post "/" do
    # postman_header = request.env['HTTP_AUTHORIZATION']
    # test_value = request.env['HTTP_TEST']
    # test_value = request.env['HTTP_TEST']
    body = JSON.parse(request.body.read.to_s)

    email = body["email"]
    password = body["password"]


    puts email
    puts password
    {
      # key1: "value1",
      # key2: "value2",
      # header: "#{postman_header}",
      # test: "#{test_value}"
      body_key: "#{body}"
    }.to_json

  end


end

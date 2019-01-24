class ApiController < AppController

  get "/" do
    erb :"login/index.html"
  end

  # If post request sent to /api, finds email & password in JSON attached
  post "/" do
    body = JSON.parse(request.body.read.to_s)
    email = body["email"]
    password = body["password"]

    # If email & password match an entry in the database
    if (Login.password_match? email.downcase, password) == true
      key = "It's a secret to everybody"
      digest = OpenSSL::Digest.new('sha1')
      secret = OpenSSL::HMAC.new(key, digest)

      payload = {message: 'You have been authenticated'}
      token = JWT.encode payload, nil, 'none'

      # Returns a JSON Web Token
      {
        success: true,
        message: "Enjoy your token",
        token: token
      }.to_json

    end

  end

end

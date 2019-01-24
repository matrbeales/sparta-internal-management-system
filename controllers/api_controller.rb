class ApiController < AppController

  get "/" do
    erb :"login/index.html"
  end

  post "/" do
    body = JSON.parse(request.body.read.to_s)
    email = body["email"]
    password = body["password"]

    if (Login.password_match? email.downcase, password) == true
      key = "It's a secret to everybody"
      digest = OpenSSL::Digest.new('sha1')
      secret = OpenSSL::HMAC.new(key, digest)

      payload = {message: 'You have been authenticated'}
      token = JWT.encode payload, nil, 'none'

      {
        success: true,
        message: "Enjoy your token",
        token: token
      }.to_json

    end

  end

end

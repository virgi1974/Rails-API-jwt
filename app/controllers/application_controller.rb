class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private

  def check_jwt_token
    jwt_token = request.headers[:HTTP_AUTHORIZATION].split(" ")[1]
    secret = User::SECRET_KEY_FOR_JWT

    decoded_info = JWT.decode(jwt_token, secret, true, { algorithm: 'HS256' }).first

    expired_jwt_token = decoded_info["exp"] < Time.now.to_i

    valid_api_user = User.find_by(authentication_token: decoded_info["authentication_token"])

    if valid_api_user && !expired_jwt_token
      # continuamos la lógica del controlador al que se llame
    else
      head(:unauthorized)
    end

  rescue  JWT::VerificationError => e
    render json: { error: "no jwt token in the request" },status: :unauthorized
  end
end

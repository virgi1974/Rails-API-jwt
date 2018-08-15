class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # random key que usaremos para pruebasen la codificación de JWT
  # TODO hacer que sea una segura tipo Rails::Secrets.key
  SECRET_KEY_FOR_JWT = "ahjgfjasgfjkasgfkagsfhgaskhfgashfgaksg"

  def set_jwt_token
    expiration = (Time.now + 2.weeks).to_i
    jwt = JWT.encode(
      { time: Time.now.to_s, authentication_token: self.authentication_token, exp: expiration },
      SECRET_KEY_FOR_JWT,
      'HS256'
    )

    jwt
  end
end

class V1::SessionsController < ApplicationController

  def create
    @user = User.where(email: params[:email]).first

    if @user.valid_password?(params[:password])

      # el equivalente a crear una sesión es generar el token que
      # se va a usar a partir de ahora
      jwt = @user.set_jwt_token

      # devolvemos el jwt generado para que el cliente lo use a partir de ahora
      render :create, locals: {jwt: jwt}, status: :created
    else
      head(:unauthorized)
    end

  end

  def destroy
    
  end
end
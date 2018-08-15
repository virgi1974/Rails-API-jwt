
class V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render :create
    else
      head(:unprocessable_entity)
    end
  end
end 

private

def user_params
  params.require(:user).permit(:email, :password, :password_confirmation)
end
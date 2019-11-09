class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: { msg: "User #{user.username} was created", succeeded: true }
    else
      render json: { msg: user.errors.full_messages.join("\n"), succeeded: false }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end

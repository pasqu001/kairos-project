class UsersController < ApplicationController
  def add_photo
    @user = User.new

  end

  private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

end

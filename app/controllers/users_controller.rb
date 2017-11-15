class UsersController < ApplicationController
  def add_photo
    @user = User.new
    @peep_params = params['peeps']
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

end

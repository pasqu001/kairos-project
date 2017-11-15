class UsersController < ApplicationController
  def new_photo
    @user = User.new
    @peep_params = params['user']
    render :add_photo
  end

  def add_photo
    @user = User.new(user_params)
    if @user.save
      client = Kairos::Client.new(:app_id => ENV['KAIROS_APP_ID'], :app_key => ENV['KAIROS_APP_KEY'])
      client.enroll(:url => params[:img], :subject_id => @user.id, :gallery_name => 'refresh_kairos')
      redirect_to event_path(1) #should be a valid instance of an event
    else
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

end

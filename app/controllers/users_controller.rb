require 'kairos'
class UsersController < ApplicationController

  def new_photo
    @user = User.new
    @peep_params = params['user']
    render :add_photo
  end

  def show
    @user = User.find(params[:id])
  end

  def add_photo
    @user = User.new(user_params)
    if @user.save
      client = Kairos::Client.new(:app_id => ENV['KAIROS_APP_ID'], :app_key => ENV['KAIROS_APP_KEY'])
      client.enroll(:url => params[:img], :subject_id => @user.id, :gallery_name => 'refresh_kairos')
      redirect_to @user
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      client = Kairos::Client.new(:app_id => ENV['KAIROS_APP_ID'], :app_key => ENV['KAIROS_APP_KEY'])
      client.enroll(:url => params[:img], :subject_id => @user.id, :gallery_name => 'refreshkairos')
      redirect_to @user
      
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

end

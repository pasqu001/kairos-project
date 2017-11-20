require 'kairos'
class HomeController < ApplicationController

  def verify_photo
    @user = User.new
    @response = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{@event.event_id}/attendees/?token=R3MLTYFWNHNDB53GOBCP")
    @response1 = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{@event.event_id}/?token=R3MLTYFWNHNDB53GOBCP")
    @peeps = @response['attendees']
    @event_name = @response1['name']['text']
    @user = User.new(user_params)
    client = Kairos::Client.new(:app_id => ENV['KAIROS_APP_ID'], :app_key => ENV['KAIROS_APP_KEY'])
    client.enroll(:url => params[:img], :subject_id => @user.id, :gallery_name => 'refreshkairos')
  end

end

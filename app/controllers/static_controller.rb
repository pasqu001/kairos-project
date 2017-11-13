class StaticController < ApplicationController
  def event_home

    @response = HTTParty.get("https://www.eventbriteapi.com/v3/events/39707355770/attendees/?token=R3MLTYFWNHNDB53GOBCP")

  end
end

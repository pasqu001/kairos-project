
class HomeController < ApplicationController
  def index
  	response = HTTParty.get('https://www.eventbriteapi.com/v3/events/39778577797/attendees/?token=WYYVY4N37HIWMKE57EY5')
  	@people = response['attendees']
  end
end

		
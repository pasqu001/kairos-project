require 'kairos'
require 'selenium-webdriver'
require 'capybara'
require 'httparty'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :verify_photo, :send_photo]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @user = User.new
    @response = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{@event.event_id}/attendees/?token=R3MLTYFWNHNDB53GOBCP")
    @response1 = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{@event.event_id}/?token=R3MLTYFWNHNDB53GOBCP")
    @peeps = @response['attendees']
    @event_name = @response1['name']['text']
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def verify_photo

  end

  def send_photo
    client = Kairos::Client.new(:app_id => ENV['KAIROS_APP_ID'], :app_key => ENV['KAIROS_APP_KEY'])
    @face_response = client.recognize(:url => params[:img], :gallery_name => 'refreshkairos', :threshold => '.8', :max_num_results => '1')
    @face_found = @face_response['images'] [0]['transaction']['status']
    # render json: @face_response
    @kairos_user_id = @face_response['images'] [0]['transaction']['subject_id'].to_i
    if @face_found == "success"
      @found_user = User.find(@kairos_user_id)
      @found_user_email = @found_user.email
      @response = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{@event.event_id}/attendees/?token=R3MLTYFWNHNDB53GOBCP")
      i = 0
      while i < @response['attendees'].length
        case
        when @response['attendees'][i]['profile']['email'].include?(@found_user_email)
            @user_event_id = @response['attendees'][i]['id']
        end
        i += 1
      end

      Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(app, browser: :chrome)
      end
      Capybara.javascript_driver = :chrome
      Capybara.configure do |config|
        config.default_max_wait_time = 10 # seconds
        config.default_driver = :selenium
      end
      # Visit
      browser = Capybara.current_session
      driver = browser.driver.browser

      browser.visit "https://www.eventbrite.com/checkin?eid=#{@event.event_id}"
      browser.fill_in('signin-email', :with => 'raulmartinez1855@gmail.com')
      browser.find('button').click
      browser.fill_in('password', :with => 'ninja150')
      browser.find('button[type="submit"]').click

      if browser.find("span[title='#{@found_user_email}']")
        browser.find("span#checkin_button_#{@user_event_id}").click
      else
        puts "nah"
      end
      sleep 2
    else
      "YOU SUCK GO SIGN UP OR GET A BETTER FACE"
    end
  end

  def welcome
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_id)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end

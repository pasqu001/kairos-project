class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @response = HTTParty.get("https://www.eventbriteapi.com/v3/events/#{@event.event_id}/attendees/?token=R3MLTYFWNHNDB53GOBCP")
    @attendee_list_hashes = []
    @attendee_list_arrays = []
    i = 0
    while i < @response['attendees'].length
      @attendee_list_hashes << {
                      first_name: @response['attendees'][i]['profile']['first_name'],
                      last_name: @response['attendees'][i]['profile']['last_name'],
                      email: @response['attendees'][i]['profile']['email'],
                      user_event_id: @response['attendees'][i]['id']
                    }
      i += 1
    end

    i = 0
    while i < @response['attendees'].length
      @attendee_list_arrays << [
                      @response['attendees'][i]['profile']['first_name'],
                      @response['attendees'][i]['profile']['last_name'],
                      @response['attendees'][i]['profile']['email'],
                      @response['attendees'][i]['id']
                    ]
      i += 1
    end


    @peeps = @response['attendees']

    # @peeps.each do |show|
    #   show['profile']['first_name']
    #   show['profile']['last_name']
    #   show['profile']['email']
    #   show['id']
    # end


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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_id)
    end
end

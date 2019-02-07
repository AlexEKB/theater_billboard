class EventsController < ApplicationController
  before_action :set_event, only: [:destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create

    @event = Event.new(event_params)

    if @event.save
      redirect_to events_url, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html {redirect_to events_url, notice: 'Event was successfully destroyed.'}
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :started_at, :end_at)
  end
end

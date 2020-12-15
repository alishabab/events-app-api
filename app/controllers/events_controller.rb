class EventsController < ApplicationController
  def index
    @events = Event.all
    render json: @events
  end

  def show
    @event = Event.find(params[:id])
    render json: @event
  end

  def create
    @event = @current_user.created_events.build(event_params)
    if @event.save
      render json: @event, status: :create
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def created_events
    user = User.find(params[:id])
    render json: user.created_events
  end

  def attended_events
    user = User.find(params[:id])
    render json: user.attended_events
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    render json: { message: 'Event deleted' }, status: :ok
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :description)
  end
end

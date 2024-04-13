class EventController < ApplicationController
  def show 
    @events = Event.where(name: ['Event A','Event B'])
  end

  def create_event
    event = Event.find_by_id(params[:id])
    user = current_user
    message = Events::Wrapper.new(event,user).process_event
    flash[:notice] = message
    redirect_to event_path
  end
end
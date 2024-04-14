class EventController < ApplicationController
  def show 
    @events = Event.where(name: ['Event A','Event B'])
  end

  def create_event
    puts "Received params: #{params[:id]}"
    event_object = Event.find_by_id(params[:id])
    user_object = current_user
    puts "User is #{user_object.email}"
    message = Events::Wrapper.new(event_object,user_object).process_event
    flash[:notice] = message
    redirect_to event_path
  end
end
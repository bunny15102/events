module Events
  class Wrapper
    def initialize(event,user)
      @event = event
      @user = user
    end

    def process_event
      email_response = nil 

      create_event_response = Events::TriggerEvent.new(@user).make_api_call
      
      if @event.notification_enabled
        email_response = Events::SendEmail.new(@user).make_api_call
      end
      message = generate_message_from_response(create_event_response,email_response)
      return message
    end

    def generate_message_from_response(create_event_response,email_response)
      message = "Something Went Wrong!!"
      create_event_response = JSON.parse(create_event_response.body).with_indifferent_access
      
      if create_event_response["code"] == "Success"
        message = "#{@event.name} created successfuly"
        if email_response.present? 
          email_response = JSON.parse(email_response.body).with_indifferent_access
          if email_response["code"] == "Success"
            message << " and email sent to the user"
          else
            message << " but sending email to the user failed"
          end
        end
      elsif create_event_response["code"] == "UnknownEmailError"
        message = "User is not associated"
      end
      return message
    end
  end
end
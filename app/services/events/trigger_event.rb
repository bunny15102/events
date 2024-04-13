module Events
  class TriggerEvent < Iterable
    def make_api_call
      payload = create_payload
      response = @api_helper.post("events/trackWebPushClick",payload) 
      return response
    end

    def create_payload
      {
        "email": @user.email,
        "messageId": "Create Event",
        "campaignId": 0,
      }
    end
  end
end
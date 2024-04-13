module Events
  class SendEmail < Iterable
    def make_api_call
      payload = create_payload
      response = @api_helper.post("email/target",payload) 
      return response
    end

    def create_payload 
      {
        "campaignId": 0,
        "recipientEmail": @user.email,
        "dataFields": {body: "Thank you for showing your interest"},
      }
    end
  end 
end
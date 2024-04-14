require 'rails_helper'

RSpec.describe Events::SendEmail do
  let(:user) { create(:user, email: 'test@example.com', password: 'test@12345!') }
  let(:send_email) { described_class.new(user) }

  describe '#make_api_call' do
    it 'makes an API call and returns a response object' do
      expected_body = '{"code": "Success"}'

      response = send_email.make_api_call
      expect(response).to be_a(Faraday::Response)
      expect(response.body).to eq(expected_body)
    end
  end

  describe '#create_payload' do
    it 'returns a hash containing campaignId, recipientEmail, and dataFields' do
      expected_payload = {
      :campaignId => 0,
      :recipientEmail => user.email,
      :dataFields => { body: "Thank you for showing your interest" }
      }

      payload = send_email.create_payload
      expect(payload).to eq(expected_payload)
    end
  end
end

require 'rails_helper'

RSpec.describe Events::TriggerEvent do
  let(:user) { create(:user, email: 'test@example.com', password: 'test@12345!') }
  let(:trigger_event) { described_class.new(user) }

  describe '#make_api_call' do
    it 'makes an API call and returns a response object' do
      expected_body = '{"code": "Success"}'

      response = trigger_event.make_api_call
      expect(response).to be_a(Faraday::Response)
      expect(response.body).to eq(expected_body)
    end
  end

  describe '#create_payload' do
    it 'returns a hash containing email, messageId, and campaignId' do
      expected_payload = {
        :email => user.email,
        :messageId => "Create Event",
        :campaignId => 0
      }

      payload = trigger_event.create_payload
      expect(payload).to eq(expected_payload)
    end
  end
end

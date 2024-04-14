# spec/services/events/wrapper_spec.rb
require 'rails_helper'

RSpec.describe Events::Wrapper do
  let(:event) { instance_double('Event', name: 'Test Event', notification_enabled: true) }
  let(:user) { instance_double('User') }

  describe '#initialize' do
    it 'sets up a wrapper with an event and a user' do
      wrapper = described_class.new(event, user)
      expect(wrapper.instance_variable_get(:@event)).to eq(event)
      expect(wrapper.instance_variable_get(:@user)).to eq(user)
    end
  end

  describe '#process_event' do
    let(:trigger_event_response) { double('trigger_event_response', body: '{"code": "Success"}') }
    let(:send_email_response) { double('send_email_response', body: '{"code": "Success"}') }

    it 'calls TriggerEvent and SendEmail' do
      expect(Events::TriggerEvent).to receive(:new).with(user).and_return(double('trigger_event', make_api_call: trigger_event_response))
      expect(Events::SendEmail).to receive(:new).with(user).and_return(double('send_email', make_api_call: send_email_response))
      wrapper = described_class.new(event, user)
      wrapper.process_event
    end

    it 'generates a message based on the responses' do
      allow(Events::TriggerEvent).to receive(:new).with(user).and_return(double('trigger_event', make_api_call: trigger_event_response))
      allow(Events::SendEmail).to receive(:new).with(user).and_return(double('send_email', make_api_call: send_email_response))
      wrapper = described_class.new(event, user)
      expect(wrapper.process_event).to eq('Test Event created successfuly and email sent to the user')
    end

    context 'when notification is disabled' do
      let(:event) { instance_double('Event', name: 'Test Event', notification_enabled: false) }

      it 'calls TriggerEvent only' do
        expect(Events::TriggerEvent).to receive(:new).with(user).and_return(double('trigger_event', make_api_call: trigger_event_response))
        expect(Events::SendEmail).not_to receive(:new)
        wrapper = described_class.new(event, user)
        wrapper.process_event
      end
    end

    context 'when API responses indicate errors' do
      let(:trigger_event_response) { double('trigger_event_response', body: '{"code": "Error"}') }
      let(:send_email_response) { double('send_email_response', body: '{"code": "Error"}') }

      it 'generates an error message' do
        allow(Events::TriggerEvent).to receive(:new).with(user).and_return(double('trigger_event', make_api_call: trigger_event_response))
        allow(Events::SendEmail).to receive(:new).with(user).and_return(double('send_email', make_api_call: send_email_response))
        wrapper = described_class.new(event, user)
        expect(wrapper.process_event).to eq('Something Went Wrong!!')
      end
    end
  end

  describe '#generate_message_from_response' do
    it 'generates a message based on the response' do
      wrapper = described_class.new(event, user)
      create_event_response = double('create_event_response', body: '{"code": "Success"}')
      email_response = double('email_response', body: '{"code": "Success"}')
      expect(wrapper.generate_message_from_response(create_event_response, email_response)).to eq('Test Event created successfuly and email sent to the user')
    end

    it 'generates a message for unknown email error' do
      wrapper = described_class.new(event, user)
      create_event_response = double('create_event_response', body: '{"code": "UnknownEmailError"}')
      email_response = nil
      expect(wrapper.generate_message_from_response(create_event_response, email_response)).to eq('User is not associated')
    end

    it 'generates a default error message' do
      wrapper = described_class.new(event, user)
      create_event_response = double('create_event_response', body: '{"code": "Error"}')
      email_response = double('email_response', body: '{"code": "Error"}')
      expect(wrapper.generate_message_from_response(create_event_response, email_response)).to eq('Something Went Wrong!!')
    end
  end
end

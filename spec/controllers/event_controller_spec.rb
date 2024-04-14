require 'rails_helper'

RSpec.describe EventController, type: :controller do
  let(:user) { create(:user, email: 'test@test.com', password: 'test@1234!') } 
  let(:event_a) { create(:event, id: 1, name: 'Event A') }
  let(:event_b) { create(:event, id: 2, name: 'Event B') }
  before { sign_in user }

  describe 'GET #show' do
    it 'assigns events with names Event A and Event B to @events' do
      get :show
      expect(assigns(:events)).to match_array([event_a, event_b])
    end

    it 'renders the show template' do
      get :show
      expect(response).to render_template(:show)
    end
  end

   describe 'POST #create_event' do
    let(:params) { { id: event_a.id } }
    before do
      # Stub the process_event method to return a specific message
      allow_any_instance_of(Events::Wrapper).to receive(:process_event).and_return('Event A created successfully')
    end

    it 'sets a flash notice message' do
      post :create_event, params: params
      expect(flash[:notice]).to eq('Event A created successfully')
    end

    it 'redirects to event_path' do
      post :create_event, params: params
      expect(response).to redirect_to(event_path)
    end
   end
end
require 'rails_helper'

RSpec.describe WistiaEvent::EventsController, type: :controller do
  routes { ::WistiaEvent::Engine.routes }

  context 'wistia checks for working endpoint' do
    describe 'HEAD index' do
      it 'returns status 200' do
        head :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context 'with valid event params' do
    describe 'POST create' do
      let(:params) { {wistia_events: webhook_example_events('media_updated')} }

      it 'returns status 200' do
        post :create, params: params
        expect(response).to have_http_status(:ok)
      end

      it 'calls WistiaEvent.process' do
        allow(WistiaEvent).to receive(:process).and_return(true)
        expect(WistiaEvent).to receive(:process)
        post :create, params: params
      end
    end
  end
end

require 'spec_helper'

RSpec.describe ZoomEvent do
  let(:events) { [] }
  let(:subscriber) { ->(evt) { events << evt } }
  let(:reject_event) { double('reject') }

  describe '.configure' do
    it 'yields itself to the block' do
      yielded = nil
      ZoomEvent.configure { |events| yielded = events }
      expect(yielded).to eq ZoomEvent
    end

    it 'requires a block argument' do
      expect { ZoomEvent.configure }.to raise_error ArgumentError
    end
  end

  describe '.process' do
    let(:json) { webhook_example_events('rejects') }
    let(:params) { {'zoom_events' =>  json} }

    it 'calls instrument for each event' do
      ZoomEvent.subscribe('reject', subscriber)
      ZoomEvent.process(params)
      expect(events).to eq JSON.parse(json)
    end
  end

  describe 'subscribing to a specific event type' do
    before do
      allow(reject_event).to receive(:[]).with('event').and_return('reject')
    end

    context 'with a subscriber that responds to #call' do
      it 'calls the subscriber with the event' do
        ZoomEvent.subscribe('reject', subscriber)
        expect(subscriber).to receive(:call).with(reject_event)
        ZoomEvent.instrument(reject_event)
      end
    end
  end
end

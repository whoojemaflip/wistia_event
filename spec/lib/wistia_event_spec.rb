require 'spec_helper'

RSpec.describe WistiaEvent do
  let(:events) { [] }
  let(:subscriber) { ->(evt) { events << evt } }
  let(:event) { double('wistia.event') }

  describe '.configure' do
    it 'yields itself to the block' do
      yielded = nil
      WistiaEvent.configure { |events| yielded = events }
      expect(yielded).to eq WistiaEvent
    end

    it 'requires a block argument' do
      expect { WistiaEvent.configure }.to raise_error ArgumentError
    end
  end

  describe '.process' do
    let(:params) { webhook_example_events('media_updated') }

    it 'calls instrument for each event' do
      WistiaEvent.subscribe('media.updated', subscriber)
      WistiaEvent.process(params)
      expect(events).to eq params['events'].map { |e| e['payload'] }
    end
  end

  describe 'subscribing to a specific event type' do
    context 'with a subscriber that responds to #call' do
      it 'calls the subscriber with the event' do
        WistiaEvent.subscribe('media.updated', subscriber)
        event = webhook_example_events('media_updated')
        expect(subscriber).to receive(:call).with(event['events'][0]['payload'])
        WistiaEvent.process(event)
      end
    end
  end
end

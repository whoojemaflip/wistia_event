require 'spec_helper'

RSpec.describe ZoomEvent do
  let(:events) { [] }
  let(:subscriber) { ->(evt) { events << evt } }
  let(:meeting_started_event) { double('meeting.start') }

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
    let(:params) { webhook_example_events('meeting.started') }

    it 'calls instrument for each event' do
      ZoomEvent.subscribe('meeting.started', subscriber)
      ZoomEvent.process(params)
      expect(events).to eq [params['payload']]
    end
  end

  describe 'subscribing to a specific event type' do
    context 'with a subscriber that responds to #call' do
      it 'calls the subscriber with the event' do
        ZoomEvent.subscribe('meeting.started', subscriber)
        event = webhook_example_events('meeting.started')
        expect(subscriber).to receive(:call).with(event['payload'])
        ZoomEvent.process(event)
      end
    end
  end
end

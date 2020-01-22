require 'pry'
require File.expand_path('../../lib/zoom_event', __FILE__)

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.order = 'random'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include WebhookRequest

  # config.before do
  #   @event_retriever = ZoomEvent.event_retriever
  #   @notifier = ZoomEvent.backend.notifier
  #   ZoomEvent.backend.notifier = @notifier.class.new
  # end

  # config.after do
  #   ZoomEvent.event_retriever = @event_retriever
  #   ZoomEvent.backend.notifier = @notifier
  # end
end

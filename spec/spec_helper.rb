require 'pry'
require File.expand_path('../../lib/wistia_event', __FILE__)

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.order = 'random'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include WebhookRequest

  # config.before do
  #   @event_retriever = WistiaEvent.event_retriever
  #   @notifier = WistiaEvent.backend.notifier
  #   WistiaEvent.backend.notifier = @notifier.class.new
  # end

  # config.after do
  #   WistiaEvent.event_retriever = @event_retriever
  #   WistiaEvent.backend.notifier = @notifier
  # end
end

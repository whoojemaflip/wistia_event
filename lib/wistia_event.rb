require 'active_support/notifications'
require 'wistia_event/version'
require 'wistia_event/engine' if defined?(Rails)
require 'json'

module WistiaEvent

  class << self
    attr_accessor :adapter, :backend, :namespace

    def configure(&block)
      raise ArgumentError, 'must provide a block' unless block_given?
      block.arity.zero? ? instance_eval(&block) : yield(self)
    end

    def process(params)
      events = params.fetch('events', [])
      events.each do |event|
        instrument(event['type'], event['payload'])
      end
    end

    def instrument(event, payload)
      backend.instrument namespace.call(event), payload
    end

    def subscribe(name, callable = Proc.new)
      backend.subscribe namespace.to_regexp(name), adapter.call(callable)
    end

  end

  class Namespace < Struct.new(:value, :delimiter)
    def call(name = nil)
      "#{value}#{delimiter}#{name}"
    end

    def to_regexp(name = nil)
      %r{^#{Regexp.escape call(name)}}
    end
  end

  class NotificationAdapter < Struct.new(:subscriber)
    def self.call(callable)
      new(callable)
    end

    def call(*args)
      payload = args.last
      subscriber.call(payload)
    end
  end

  class Error < StandardError; end
  class UnauthorizedError < Error; end

  self.adapter = NotificationAdapter
  self.backend = ActiveSupport::Notifications
  self.namespace = Namespace.new('wistia_event', '.')

end

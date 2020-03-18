[![Gem Version](https://badge.fury.io/rb/wistia_event.svg)](http://badge.fury.io/rb/wistia_event)

# WistiaEvent

WistiaEvent is built on the ActiveSupport::Notifications API. Define subscribers to handle specific event types. Subscribers can be a block or an object that responds to #call.


## Installation

### Add it to your Gemfile

```ruby
# Gemfile
gem 'wistia_event'
```

And then execute:

    $ bundle

## Usage

### Mount the engine in your routes

```ruby
# config/routes.rb
  mount WistiaEvent::Engine => '/wistia'
```

### Setup the initializer

```ruby
# config/initializers/wistia_event.rb
WistiaEvent.configure do |events|
  events.subscribe 'reject', RejectHandler
end
```

### Subscriber responds to call

```ruby
# app/wistia_handlers/reject_handler.rb
class RejectHandler
  def self.call(event)
    # your code here
  end
end
```

### Configure Wistia webhooks to use your endpoint

At the Wistia website, create a webhook that points to your server with the path `/wistia/events`. A service like [Ngrok](https://ngrok.com/) or [Ultrahook](http://www.ultrahook.com/) can be really useful in creating a tunnel to your local server and inspecting the request payloads.


## Thanks

WistiaEvent ~~takes inspiration from~~ is a direct rip-off of the [stripe_event](https://github.com/integrallis/stripe_event) gem, which takes it's inspiration from [Webmachine](https://github.com/seancribbs/webmachine-ruby/blob/6edaecea1ceab7c2c54fc5e83446317524f6bb8b/lib/webmachine/events.rb), which is inspired by Erlang. It's turtles all the way down.


## TODO:

* Get it on Travis
* Write docs with RDoc/YARD
* More test coverage
* Incoming webhook requests are authenticated
* Get it on Coveralls
* Get it on Code Climate


## Contributing

1. Fork it ( https://github.com/[my-github-username]/wistia_event/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

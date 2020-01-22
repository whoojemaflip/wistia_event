module ZoomEvent
  class EventsController < ActionController::Base
    skip_before_action :verify_authenticity_token, raise: false

    def index
      head :ok
    end

    def create
      ZoomEvent.process(params)
      head :ok
    # rescue ZoomEvent::UnauthorizedError
    #   head :unauthorized
    end
  end
end

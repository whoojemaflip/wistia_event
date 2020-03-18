module WistiaEvent
  class EventsController < ActionController::Base
    skip_before_action :verify_authenticity_token, raise: false

    def index
      head :ok
    end

    def create
      WistiaEvent.process(permitted_params)
      head :ok
    end

    private

    def permitted_params
      params.permit(:event, payload: {}).to_h
    end
  end
end

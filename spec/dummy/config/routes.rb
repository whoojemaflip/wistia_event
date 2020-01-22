require 'zoom_event/engine'

Rails.application.routes.draw do
  mount ZoomEvent::Engine => '/zoom'
end

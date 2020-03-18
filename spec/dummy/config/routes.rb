require 'wistia_event/engine'

Rails.application.routes.draw do
  mount WistiaEvent::Engine => '/wistia'
end

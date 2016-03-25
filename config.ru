require "./app.rb"
require "newrelic_rpm"

NewRelic::Agent.after_fork(:force_reconnect => true)

run Sinatra::Application

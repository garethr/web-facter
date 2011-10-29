require 'rack'
require 'facter'
require 'json'

class App
  def call env
    response = Rack::Response.new
    response.header['Content-Type'] = 'application/json'
    response.write JSON.pretty_generate(Facter.to_hash)
    response.finish
  end
end

run App.new

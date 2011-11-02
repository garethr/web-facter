require "web-facter/version"
require 'rack'
require 'facter'
require 'json'
require 'parseconfig'

module  WebFacter
  class App
    def call(env)
      response = Rack::Response.new
      response.header['Content-Type'] = 'application/json'
      response.write JSON.pretty_generate(Facter.to_hash)
      response.finish
    end

    def add_auth(conf)
      application = Rack::Auth::Basic.new(self) do |username, password|
        stored_username = conf.get_value('username')
        username_check = stored_username ? stored_username == username : true
        password_check = conf.get_value('password') == password
        username_check && password_check
      end
      application.realm = 'Web Facter'
      application
    end

    def self.run!(options)
      application = self.new

      daemonize = options[:daemonize]
      port = options[:port]

      if options[:config]
        conf = ParseConfig.new(options[:config])
        application = application.add_auth(conf) if conf.get_value('password')
        daemonize = conf.get_value('daemonize') ? conf.get_value('daemonize') == "true" : daemonize
        port = conf.get_value('port') ? conf.get_value('port') : port
      end

      Rack::Server.new(:app => application, :Port => port, :daemonize => daemonize).start
r
    end
  end
end



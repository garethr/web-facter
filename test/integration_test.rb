require "test_helper"
require "web-facter"

class SearchTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    WebFacter::App.new
  end

  def test_view_renders_successfully
    get "/"
    assert last_response.ok?
  end

  def test_view_returns_json
    get "/"
    json = JSON.load(last_response.body)
    assert json.keys.include?("architecture")
  end

end

class AuthenticationTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    conf = mock()
    conf.expects(:get_value).with('username').returns("admin")
    conf.expects(:get_value).with('password').returns("password")
    WebFacter::App.new().add_auth(conf)
  end

  def test_view_requires_authentication
    authorize 'evil', 'password'
    get "/"
    assert_equal 401, last_response.status
  end

  def test_view_renders_with_auth_details
    authorize 'admin', 'password'
    get "/"
    assert last_response.ok?
  end

end

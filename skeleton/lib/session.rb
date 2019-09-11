require 'json'
require 'byebug'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @cookie_session ||= req.env["rack.request.cookie_hash"]
  end

  def [](key)
    json_hash = JSON.parse(@cookie_session["_rails_lite_app"])
    json_hash[key]
  end

  def []=(key, val)
    debugger
    json_hash = JSON.parse(@cookie_session["_rails_lite_app"])
    debugger
    json_hash[key] = val

  

  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
  end
end

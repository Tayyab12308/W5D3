require 'rack'


app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  # res['Location'] = url
  res.write(req.path)
  res.finish
end

# def url
#   # 'localhost:3000' + '/i/love/app/academy'
# end

Rack::Server.start(
  app: app,
  Port: 3000
)
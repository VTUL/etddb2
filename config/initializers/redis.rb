Redis.current = Redis.new(port: 2999)
if Rails.env = 'production'
  Redis.current.select 1
end

Resque.redis = Redis.current

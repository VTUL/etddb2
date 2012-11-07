Redis.current = Redis.new(port: 2999)
Resque.redis = Redis.current

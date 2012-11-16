Redis.current = Redis.new(port: 2999)
if Rails.env = 'production'
  Redis.current.select 1
end

Resque.redis = Redis.current
Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/resque_schedule.yml'))

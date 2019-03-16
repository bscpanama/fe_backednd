Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['DATA_REDIS_HOST']}" || 'redis://127.0.0.1:6379'}
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['DATA_REDIS_HOST']}" || 'redis://127.0.0.1:6379'}
end

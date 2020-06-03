# redisと接続するためredisの場所を指定
Sidekiq.configure_server do |config|
  config.redis = { url: Settings.sidekiq[:server] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Settings.sidekiq[:client] }
end
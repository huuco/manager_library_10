Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:1111111111111111@lab.redistogo.com:9254/' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:1111111111111111@lab.redistogo.com:9254/' }
end

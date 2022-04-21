require 'sidekiq'

Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://redis:6379' }
end

require 'sidekiq/web'
run Sidekiq::Web
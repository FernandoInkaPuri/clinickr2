require 'sidekiq'
require './importer'

Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://redis:6379' }
end

Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://redis:6379' }
end

class OurWorker
    include Sidekiq::Job
    
    def perform(filename)
        Importer.call(filename)
    end
end
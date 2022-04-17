require 'sidekiq'

config_redis = {
    url: 'redis://mymaster:6379',
    role: :master,
    sentinels: [
        { host: 'sentinel://sentinel1.com', port: '26379' },
        { host: 'sentinel://sentinel2.com', port: '26379' },
        { host: 'sentinel://sentinel3.com', port: '26379' }
    ]
}

Sidekiq.configure_server do |config|
    config.redis = config_redis
end

Sidekiq.configure_client do |config|
    config.redis = config_redis
end

class OurWorker
    include Sidekiq::Worker
    def perform(archive)
        case archive
        when archive.size > 20.000
            sleep 20
        when archive.size > 10.000 && archive.size < 20.000
            sleep 10
        else
            sleep 1
        end
    end
end
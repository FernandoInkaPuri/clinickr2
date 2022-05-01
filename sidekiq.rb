require 'sidekiq'
require './importer'

# Neste caso as linhas abaixo que seriam necessárias não serão mais pois no comando docker já especifiquei
# as configurações do redis com variavel de ambiente com o comando -e REDIS_URL=redis://redis:6379/0  
# Sidekiq.configure_server do |config|
#     config.redis = { url: 'redis://redis:6379' }
# end

# Sidekiq.configure_client do |config|
#     config.redis = { url: 'redis://redis:6379' }
# end

class OurWorker
    include Sidekiq::Job
    
    def perform(filename)
        Importer.call(filename)
    end
end
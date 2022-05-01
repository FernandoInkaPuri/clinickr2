require "sidekiq"
require "sidekiq/web"
require 'securerandom'

# Neste caso as linhas abaixo que seriam necessárias não serão mais pois no comando docker já especifiquei
# as configurações do redis com variavel de ambiente com o comando -e REDIS_URL=redis://redis:6379/0  
# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://redis:6379' }
# end

# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://redis:6379' }
# end

use Rack::Session::Cookie, secret: SecureRandom.hex(32), same_site: true, max_age: 86400
run Sidekiq::Web
require 'sidekiq'
require 'sidekiq-status'

sidekiq_config = { url: ENV['ACTIVE_JOB_URL'] }

Sidekiq.configure_server do |config|
  Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes

  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes

  config.redis = sidekiq_config
end

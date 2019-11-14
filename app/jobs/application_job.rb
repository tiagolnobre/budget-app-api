class ApplicationJob < ActiveJob::Base
  include Sidekiq::Status::Worker

  queue_as :low_priority
end

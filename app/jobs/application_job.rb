# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  include Bullet::ActiveJob if Rails.env.development?
  include Sidekiq::Status::Worker

  queue_as :low_priority
end

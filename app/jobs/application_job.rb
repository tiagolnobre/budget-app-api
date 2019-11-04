class ApplicationJob < ActiveJob::Base
  queue_as :low_priority
end

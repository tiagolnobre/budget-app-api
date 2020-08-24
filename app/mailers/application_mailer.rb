# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.default_from
  layout 'mailer'
end

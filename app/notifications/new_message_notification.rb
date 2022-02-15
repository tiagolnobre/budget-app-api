# frozen_string_literal: true

# Notifications::NewMessage.with(type: 'User', message_key: :new_user).deliver_later(current_user)
#

class NewMessageNotification < Noticed::Base
  deliver_by :database, format: :to_database

  param :type, :message_key

  def to_database
    {recipient: recipient, type: self.class.name, params: params}
  end

  # I18n helpers
  def message
    t(".messages.#{params[:message_key]}")
  end
end

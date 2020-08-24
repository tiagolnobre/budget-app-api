# frozen_string_literal: true

class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    @template_partial = "user_mailer/partials/welcome"
    mail(
      to: user.email,
      subject: 'Welcome to the budget API',
    #   body: { user: user, template_partial: "user_mailer/partials/welcome" }
    ) do |format|
      format.html
    end
  end
end

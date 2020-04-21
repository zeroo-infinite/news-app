class PasswordResetMailerJob < ApplicationJob
  queue_as :default

  def perform(user, reset_password_token)
    Admin::UserMailer.password_reset(user, reset_password_token).deliver_later(wait: 1.minute)
  end
end

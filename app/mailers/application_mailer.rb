# frozen_string_literal: true

# Base mailer class responsible for handling email functionalities across the application.
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end

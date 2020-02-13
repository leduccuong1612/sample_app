class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer.default
  layout Settings.mailer.layout
end

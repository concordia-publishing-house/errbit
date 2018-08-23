class ApplicationMailer < ActionMailer::Base
  default from: Errbit::Config.email_from
  layout "mailer"
end

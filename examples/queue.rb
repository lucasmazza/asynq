require 'rubygems'
require 'bundler/setup'

require 'asynq'
require 'qu-redis'
require File.expand_path('../../spec/support/notifier', __FILE__)

name  = `git config user.name`.strip
email = `git config user.email`.strip

ActionMailer::Base.delivery_method         = :asynq
ActionMailer::Base.perform_deliveries      = true
ActionMailer::Base.asynq_settings[:using]  = :smtp
ActionMailer::Base.smtp_settings[:address] = "localhost"
ActionMailer::Base.smtp_settings[:port]    = 1025

loop do
  mail = Notifier.contact(email, name)
  mail.deliver
  puts "delivering..."
  sleep 5
end

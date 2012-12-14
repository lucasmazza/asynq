require "action_mailer"
require "qu"

require "asynq/version"
require "asynq/delivery_method"
require "asynq/worker"
require "asynq/railtie" if defined?(Rails)

module Asynq
end

ActionMailer::Base.add_delivery_method :asynq, Asynq::DeliveryMethod, :worker => Asynq::Worker, :using => :test


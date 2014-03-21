require 'asynq'

require 'support/notifier'
require 'support/qu'

Qu.backend = Qu::Backend::Test.new

ActionMailer::Base.delivery_method = :asynq
ActionMailer::Base.asynq_settings[:using] = :test
ActionMailer::Base.perform_deliveries = true

RSpec.configure do |config|
  config.before do
    Qu.backend.jobs.clear
    ActionMailer::Base.deliveries.clear
  end

  config.order = 'random'
end

require "asynq"

require "support/notifier"
require "support/qu"

Qu.backend = Qu::Backend::Test.new

ActionMailer::Base.delivery_method = :asynq
ActionMailer::Base.asynq_settings[:using] = :test
ActionMailer::Base.perform_deliveries = true

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before do
    Qu.backend.jobs.clear
    ActionMailer::Base.deliveries.clear
  end

  config.order = 'random'
end

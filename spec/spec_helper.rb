require "asynq"

require "support/notifier"
require "support/qu"

Qu.backend = Qu::Backend::Test.new

ActionMailer::Base.delivery_method = :asynq
ActionMailer::Base.perform_deliveries = true

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before do
    Qu.backend.jobs.clear
    ActionMailer::Base.deliveries.clear
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

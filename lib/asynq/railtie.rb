module Asynq
  class Railtie < Rails::Railtie
    initializer "asynq.delivery_method" do |app|
      app.config.action_mailer.delivery_method = :async
    end
  end
end
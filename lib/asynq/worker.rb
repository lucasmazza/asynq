module Asynq
  class Worker
    @queue = :email

    def self.perform(contents, options)
      message = Mail.new(contents)
      message.delivery_method(options[:delivery_method], options[:delivery_options])
      message.deliver
    end
  end
end
require 'active_support/inflector/methods'
require 'active_support/core_ext/hash/keys'
require 'mail'

module Asynq
  class Worker
    @queue = :email

    def self.perform(contents, options)
      message = Mail.new(contents)
      options.symbolize_keys!
      delivery_options = options[:delivery_options] || {}

      klass = ActiveSupport::Inflector.constantize(options[:delivery_method])
      message.delivery_method(klass, delivery_options.symbolize_keys)
      message.deliver
    end
  end
end
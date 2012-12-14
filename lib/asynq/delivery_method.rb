module Asynq
  class DeliveryMethod
    def initialize(options)
      method   = options[:using]
      @worker  = options[:worker]
      @klass   = ActionMailer::Base.delivery_methods[method]
      @options = ActionMailer::Base.send(:"#{method}_settings")
    end

    def deliver!(mail)
      Qu.enqueue @worker, mail.encoded, :delivery_method => @klass, :delivery_options => @options
    end
  end
end
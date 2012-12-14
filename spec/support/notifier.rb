class Notifier < ActionMailer::Base
  self.view_paths = File.expand_path("../views", __FILE__)

  layout false

  def contact(recipient, name)
    @recipient = recipient
    @name      = name
    mail :to => @recipient, :from => "asynq@test.com"
  end
end
class Notifier < ActionMailer::Base
  self.view_paths = File.expand_path("../views", __FILE__)

  layout false

  def contact(recipient)
    @recipient = recipient
    mail :to => @recipient
  end
end
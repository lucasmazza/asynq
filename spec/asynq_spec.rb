require 'spec_helper'

describe Asynq do
  it "delivers the message with the supplied delivery method" do
    mail = Notifier.contact("lucas@work.com")
    mail.deliver

    ActionMailer::Base.should have(0).deliveries
    Qu.backend.should have(1).job

    Qu.backend.drain
    ActionMailer::Base.deliveries.last.should == mail
  end
end
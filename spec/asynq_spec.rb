require 'spec_helper'

describe Asynq do
  it 'delivers the message with the supplied delivery method' do
    mail = Notifier.contact('lucas@work.com', 'Lucas')
    mail.deliver

    expect(ActionMailer::Base.deliveries.size).to eq(0)
    expect(Qu.backend.jobs.size).to eq(1)

    Qu.backend.drain
    expect(ActionMailer::Base.deliveries.last).to eq(mail)
  end
end

# Asynq

## An alternative approach to asynchronous e-mail delivery.

Asynq is a attempt to provide alternatives to libraries responsible for tweaking ActionMailer to
deliver e-mails in background, by monkeypatching some internals and delaying the entire mailer execution.

Asynq provides a delivery method to ActionMailer that pushes the entire `Mail::Message` object into
a queue to be delivered later using an actual method like `SMTP` or `Sendmail`, without loading your
entire application into a new process or establishing database connections to recreate your objects
into the mailer execution.

## Usage

Add `asynq` to your Gemfile, and setup in your appliction the proper ActionMailer configurations:

```ruby
# config/environments/production.rb
config.action_mailer.smtp_settings = {
  :address              => "...",
  :port                 => 587,
  :user_name            => "...",
  :password             => "...",
  :authentication       => "...",
  :enable_starttls_auto => true,
  :domain               => "..."
}
```

Asynq is backed by [Qu](github.com/bkeepers/qu), so it's important to setup an initializer to configure it properly.

```ruby
# config/initializers/qu.rb
# Let's setup Qu to use Redis
require 'qu-redis'

Qu.configure do |c|
  c.connection  = Redis::Namespace.new('myapp:qu', :redis => Redis.connect)
  c.logger      = Logger.new('log/qu.log')
end
```

Now, fire up some e-mails with your application like you are used to, and to start the queue to delivery e-mails use the `asynq` executable:

```shell
bundle exec asynq -r config/initializers/qu.rb
```

## Try it locally

The `examples` directory provides small scripts to try out Asynq using `qu-redis` and MailCatcher,
by enqueuing a few e-mails locally in Redis and delivering them to an SMTP server managed by MailCatcher.

```shell
bundle install
bundle exec mailcatcher
bundle exec examples/queue.rb
bundle exec asynq -r examples/setup.rb
```

Open up [http://localhost:1080](http://localhost:1080) and see the delivered e-mails.

## License

Copyright (c) 2012 Lucas Mazza. See LICENSE file.
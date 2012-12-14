require 'rubygems'
require 'bundler/setup'

require 'asynq/worker'
require 'qu-redis'

Qu::Worker.new(['email']).start
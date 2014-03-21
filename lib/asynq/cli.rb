require 'optparse'
require 'asynq/worker'
require 'qu'

module Asynq
  class CLI
    def initialize
      @options = { queue: 'email' }
    end

    def run(arguments)
      parse!(arguments)

      require File.expand_path(@options[:require]) if @options[:require]
      Qu::Worker.new(*@options[:queue]).start
    end

    private
    def parse!(arguments)
      parser = OptionParser.new do |o|
        o.on '-q', '--queue QUEUE', "Queue to process. (default is'#{@options[:queue]}')" do |queue|
          @options[:queue] = queue
        end

        o.on '-r', '--require FILE', 'Optional setup file to require' do |file|
          @options[:require] = file
        end

        o.on '-h', '--help', 'Outputs help' do
          puts parser
          exit(0)
        end
      end

      parser.banner = 'USAGE: asynq [options]'
      parser.parse!(arguments)
    end
  end
end

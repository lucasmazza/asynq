require "qu-immediate"

module Qu
  module Backend
    class Test < Qu::Backend::Immediate
      attr_reader :jobs

      def initialize
        @jobs = []
      end

      def enqueue(payload)
        @jobs << payload
      end

      def drain
        while job = @jobs.shift
          job.perform
        end
      end
    end
  end
end
require "sidekiq_sentinel/version"
require 'sidekiq'

module Sidekiq
  class RedisConnection
    class_eval do
      class << self
        alias :origin_client_opts :client_opts

        private
        def client_opts(*args)
          return origin_client_opts(*args) unless Sidekiq.options[:sentinel]
          require 'redis-sentinel'
          origin_client_opts(*args).merge({
            :master_name => Sidekiq.options[:sentinel][:master_name],
            :sentinels => Sidekiq.options[:sentinel][:sentinels]
          })
        end
      end
    end
  end
end

require File.expand_path('../../spec_helper', __FILE__)

describe Sidekiq::RedisConnection do
  before do
    @url     = 'redis://localhost:16397/5'
    @driver  = 'SidekiqSentinel'
    @timeout = 60
  end
  describe 'pass options without sentinel' do
    it 'returns original client_opts' do
      opts = {
        :url => @url,
        :driver => @driver
      }
      expect(Sidekiq::RedisConnection.__send__(:client_opts, @url, @driver, nil)).to eql opts
    end

    it 'returns original client_opts with timeout' do
      opts = {
        :url => @url,
        :driver => @driver,
        :timeout => @timeout
      }
      expect(Sidekiq::RedisConnection.__send__(:client_opts, @url, @driver, @timeout)).to eql opts
    end
  end

  describe 'pass options with sentinel' do
    before do
      @sentinel = {:master_name=>"example-test", :sentinels=>[{:host=>"localhost", :port=>26379}, {:host=>"localhost", :port=>26380}]}
      Sidekiq.options[:sentinel] = @sentinel
    end

    it 'returns option includes sentinel' do
      opts = {
        :url => @url,
        :driver => @driver,
        :master_name => @sentinel[:master_name],
        :sentinels  => @sentinel[:sentinels]
      }
      expect(Sidekiq::RedisConnection.__send__(:client_opts, @url, @driver, nil)).to eql opts
    end

    it 'returns option includes sentinel with timeout' do
      opts = {
        :url => @url,
        :driver => @driver,
        :timeout => @timeout,
        :master_name => @sentinel[:master_name],
        :sentinels  => @sentinel[:sentinels]
      }
      expect(Sidekiq::RedisConnection.__send__(:client_opts, @url, @driver, @timeout)).to eql opts
    end
  end
end

# SidekiqSentinel

The Sidekiq CLI will be used a Redis Sentinel cluster.

When Sidekiq.config has a key which named `sentinel`,  the sidekiq client will use redis sentinel cluster as backend.

## Dependency

- sidekiq [https://github.com/mperham/sidekiq](https://github.com/mperham/sidekiq)
- redis-sentinel [https://github.com/flyerhzm/redis-sentinel](https://github.com/flyerhzm/redis-sentinel)

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq_sentinel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq_sentinel

## Usage

1. Put your redis sentinel cluster informations to YAML file.
2. Run sidekiq with `-C` option

### config.yml example

```
# Sample configuration file for Sidekiq.
# Options here can still be overridden by cmd line args.
#   sidekiq -C config.yml
---
:sentinel:
  :master_name: example-test
  :sentinels:
  - :host: localhost
    :port: 26379
  - :host: localhost
    :port: 26380
:verbose: true
:pidfile: ./sidekiq.pid
:concurrency:  5
:queues:
  - [often, 7]
  - [default, 5]
  - [seldom, 3]
```

## Test

There are two files for testing.

- examples/config.yml (forked from sidekiq project)
- examples/sinkiq.rb (forked from sidekiq project)

You can setup redis sentinel cluster with [redis-sentinel project](https://github.com/flyerhzm/redis-sentinel) examples.

1. Setup redis sentinel cluster and watch redis with MONITOR API.
2. Run sidekiq worker `bundle exec sidekiq -C ./examples/config.yml -r examples/sinkiq.rb`
3. Run sinatra server `bundle exec ruby examples/sinkiq.rb`
4. Post messages from sinatra(http://localhost:4567)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## <a name="authors"></a> Authors

Created and maintained by [Yukihiko Sawanobori][author] (<sawanoboriyu@higanworks.com>)

## <a name="license"></a> License

MIT (see [LICENSE][license])


[author]:           https://github.com/sawanoboly
[license]:          https://github.com/giraffi/sidekiq_sentinel/blob/master/LICENSE.txt


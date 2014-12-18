# Quandl::Slack

Use this gem to automatically generate Slack notifiers for you, or to quickly generate them on the fly.

## Installation

Add this line to your application's Gemfile:

    gem 'quandl_slack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quandl_slack

## Generating your notifiers

### Automatically

First, create a `slack.yml` file and place it in `config/quandl` in your project's root folder:
```YAML
defaults: &defaults
  webhook_url: https://hooks.slack.com/services/fake/fake/fake
  notifiers: &default_notifiers
    asset_management:
      channel: '#releases'
      username: Next Asset Deployer
      icon_emoji: ':airplane:'
    stripe:
      channel: '#stripe-testing'
      username: stripe
      icon_url: 'http://lorempixel.com/48/48'
    ci:
      channel: <%= ENV.fetch('SLACK_CHANNEL', "'#development'") %>

development:
  <<: *defaults

staging:
  <<: *defaults

test:
  <<: *defaults

vagrant:
  <<: *defaults

vagrant_test:
  <<: *defaults

vagrant_staging:
  <<: *defaults

production:
  <<: *defaults
  subclasses:
    <<: *default_notifiers
    stripe:
      channel: '#stripe-events'
      username: stripe
```

Then call `Quandl::Slack.autogenerate_notifiers` in an initializer. In the example above, you will get three notifiers:
- `Quandl::Slack::AssetManagement`
- `Quandl::Slack::Stripe`
- `Quandl::Slack::Ci`

### Manually and individually

#### Provide the webhook

Every Slack notifier needs a webook. Normally, you would use the same one throughout the project, and customize the channel, username and icon on a per-notifier basis.

To provide the webhook, either set the `ENV['SLACK_WEBHOOK']` environment variable:
```Ruby
ENV['SLACK_WEBHOOK'] = 'https://hooks.slack.com/services/XXX/YYYY/ZZZ'
```
OR

Create a `config/quandl/slack.yml` file with a `webhook_url` node and call:
```Ruby
Quandl::Slack.extend(Quandl::Configurable)
```

#### Provide the environment

If your project is a Rails app or you're using `ENV['SLACK_WEBHOOK']` to set the webhook URL, you don't need to do anything.

If your project is NOT a Rails app and you're using a config file to set the webhook URL, you will also need to let `Quandl::Slack` know what the environment is, so it knows which node in the `config` file to use. You can provide the environment using the `ENV['RAILS_ENV']` or `ENV['RAKE_ENV']` environment variable. If you do not, the `default` environment will be assumed.

#### Generate the notifier!

```Ruby
Quandl::Slack.generate_notifier('your_notifier', customizations_hash)
```

## Available customizations:
These can be placed in the yml file when autogenerating notifiers, or passed to `generate_notifier` when manually generating an individual notifier:

key | example value | notes
------- | ----------- | ----
`channel` | `'#development'` | remember the hash
`icon_url` | `http://lorempixel.com/200/200/people/` |
`icon_emoji` | `':alien:'` | see [emoji cheat sheet](http://www.emoji-cheat-sheet.com/)
`username` |`The Bot` |

## Pinging your notifiers

Simply call:
```ruby
Quandl::Slack::YourNotifier.ping('your message', additional_customizations_hash)
```

See [`slack-notifier`'s readme](https://github.com/stevenosloan/slack-notifier) and [Slack's API documentation](https://api.slack.com/methods/chat.postMessage) for information about the additional customizations you can pass in.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/quandl_slack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

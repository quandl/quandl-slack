require 'fixtures/dummy_rails_app/application'
require 'spec_helper'

describe Quandl::Slack do
  describe '.autogenerate_notifiers' do
    it 'autogenerates Slack::Notifier instances' do
      Quandl::Slack.autogenerate_notifiers
      expect(Quandl::Slack::AssetManagement.client).to be_kind_of(Slack::Notifier)
      expect(Quandl::Slack::Ci.client.default_payload['channel']).to eq('#development')
    end
  end

  describe '.generate_notifier' do
    it 'generates Slack::Notifier instance' do
      ENV['SLACK_WEBHOOK'] = 'https://hooks.slack.com/services/fake/fake/fake'
      Quandl::Slack.generate_notifier('my_notifier', channel: '#stripe-testing', icon_emoji: ':christmas_tree:')
      expect(Quandl::Slack::MyNotifier.client).to be_kind_of(Slack::Notifier)
      expect(Quandl::Slack::MyNotifier.client.default_payload[:icon_emoji]).to eq(':christmas_tree:')
    end
  end
end

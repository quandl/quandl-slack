module Quandl
  module Slack
    class Base
      attr_reader :client

      def self.client
        @client = ::Slack::Notifier.new webhook_url, customizations
      end

      def self.webhook_url
        ENV['SLACK_WEBHOOK'] || Quandl::Slack.configuration.webhook_url
      end

      def self.customizations; end

      def self.ping(*args)
        client.ping(*args)
      end
    end
  end
end

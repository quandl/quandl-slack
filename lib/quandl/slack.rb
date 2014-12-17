require 'quandl/slack/version'

module Quandl
  module Slack
    extend Quandl::Configurable

    class Base
      attr_reader :client

      def self.client
        @client = ::Slack::Notifier.new Quandl::Slack.configuration.webhook_url, customizations
      end

      def self.customizations; end

      def self.ping(*args)
        client.ping(*args)
      end
    end

    def self.generate_notifiers
      configuration.notifiers.each do |subclass_name, subclass_customizations|
        name = subclass_name.camelize
        klass = Class.new(Quandl::Slack::Base) do
          define_singleton_method :customizations do
            subclass_customizations
          end
        end
        const_set name, klass
      end
    end
  end
end

Quandl::Slack.generate_notifiers

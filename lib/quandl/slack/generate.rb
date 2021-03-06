module Quandl
  module Slack
    def self.autogenerate_notifiers
      self.extend(Quandl::Configurable)
      configuration.notifiers.each do |subclass_name, subclass_customizations|
        generate_notifier(subclass_name, subclass_customizations)
      end
    end

    def self.generate_notifier(subclass_name, subclass_customizations={})
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

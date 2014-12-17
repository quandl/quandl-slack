# Mocking a Rails app
Rails = Class.new do
  def self.root
    Pathname.new(File.dirname(__FILE__))
  end

  def self.env
    'development'
  end
end

# Mocking a gemfile
require 'quandl/slack'

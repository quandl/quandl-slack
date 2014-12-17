require 'spec_helper'

describe Quandl::Slack do
  it 'automatically creates Slack::Notifier instances' do
    expect(Quandl::Slack::AssetManagement.client).to be_kind_of(Slack::Notifier)
    expect(Quandl::Slack::Ci.client.default_payload['channel']).to eq('#development')
  end
end

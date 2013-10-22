require 'spec_helper'

describe Vertebrae::Configuration do

  subject { Vertebrae::Configuration.new({}) }

  {:adapter => described_class::DEFAULT_ADAPTER,
   :scheme => described_class::DEFAULT_SCHEME,
   :ssl => described_class::DEFAULT_SSL,
   :user_agent => described_class::DEFAULT_USER_AGENT,
   :username => described_class::DEFAULT_USERNAME,
   :password => described_class::DEFAULT_PASSWORD }.each do | key, value |
      its(key) { should == value }
      its("default_#{key}") { should == value }
  end

  its(:connection_options) { should be_a Hash }
  its(:connection_options) { should be_empty }

  describe "override" do
    subject{ Vertebrae::Configuration.new({username: 'foo', password: 'bar', scheme: 'http'}) }

    its(:default_scheme) { should == described_class::DEFAULT_SCHEME }
    its(:default_username) { should == described_class::DEFAULT_USERNAME }
    its(:default_password) { should == described_class::DEFAULT_PASSWORD }

    its(:scheme) { should == 'http'}
    its(:username) { should == 'foo'}
    its(:password) { should == 'bar'}
  end

  describe "setter" do
    before(:each) do
      subject.username =  'foo'
    end
    its(:username) { should == 'foo'}
    its(:default_username) { should == described_class::DEFAULT_USERNAME }
  end

  describe 'endpoint' do
    subject { Vertebrae::Configuration.new({host: 'test.com', prefix: ''}) }

    specify { subject.host.should == 'test.com' }
    specify { subject.endpoint.should == 'https://test.com'}
  end
end
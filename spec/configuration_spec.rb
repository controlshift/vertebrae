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
    context 'with no port specification' do
      subject { Vertebrae::Configuration.new({host: 'test.com', prefix: ''}) }

      specify { expect(subject.host).to eq('test.com') }
      specify { expect(subject.endpoint).to eq('https://test.com')}
    end

    context 'with port specification' do
      subject { Vertebrae::Configuration.new({host: 'test.com', prefix: '', port: 8080}) }

      specify { expect(subject.port).to eq(8080) }
      specify { expect(subject.endpoint).to eq('https://test.com:8080')}

      context 'with prefix' do
        subject { Vertebrae::Configuration.new({host: 'test.com', prefix: '/api/v1', port: 8080}) }

        specify { expect(subject.prefix).to eq('/api/v1') }
        specify { expect(subject.endpoint).to eq('https://test.com:8080/api/v1')}
      end
    end
  end
end

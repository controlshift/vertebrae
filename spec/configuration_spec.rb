# frozen_string_literal: true

require 'spec_helper'

describe Vertebrae::Configuration do

  subject { Vertebrae::Configuration.new({}) }

  {:scheme => described_class::DEFAULT_SCHEME,
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

  describe 'adapter' do
    it 'should default to :net_http' do
      expect(subject.adapter).to eq(:net_http)
    end
  end

  describe 'adapter=' do
    it 'should allow setting and retrieval' do
      subject.adapter = :foo
      expect(subject.adapter).to eq(:foo)
    end
  end

  describe '#faraday_options' do
    subject { Vertebrae::Configuration.new(host: 'example.com') }

    it 'should include headers, ssl, and url settings by default' do
      opts = subject.faraday_options
      expect(opts.keys).to contain_exactly(:headers, :ssl, :url)
      expect(opts[:headers]).to eq({'Accept' => 'application/json;q=0.1',
                                    'Accept-Charset' => 'utf-8',
                                    'User-Agent' => 'Vertebrae REST Gem',
                                    'Content-Type' => 'application/json'})
      expect(opts[:ssl]).to eq({})
      expect(opts[:url]).to eq 'https://example.com/'
    end

    context 'with connection_options' do
      let(:connection_options) { {ssl: {verify: false},
                                  timeout: 5} }

      subject { Vertebrae::Configuration.new(host: 'example.com', connection_options: connection_options) }

      it 'should override and extend the default options' do
        opts = subject.faraday_options
        expect(opts.keys).to contain_exactly(:headers, :ssl, :timeout, :url)
        expect(opts[:headers]).to eq({'Accept' => 'application/json;q=0.1',
                                      'Accept-Charset' => 'utf-8',
                                      'User-Agent' => 'Vertebrae REST Gem',
                                      'Content-Type' => 'application/json'})
        expect(opts[:ssl]).to eq({verify: false})
        expect(opts[:url]).to eq 'https://example.com/'
        expect(opts[:timeout]).to eq 5
      end
    end

    context 'with additional_headers' do
      let(:additional_headers) { {'special-auth-token' => 'abcde12345'} }

      subject { Vertebrae::Configuration.new(host: 'example.com', additional_headers: additional_headers) }

      it 'should add the additional headers to the other headers' do
        opts = subject.faraday_options
        expect(opts.keys).to contain_exactly(:headers, :ssl, :url)
        expect(opts[:headers]).to eq({'Accept' => 'application/json;q=0.1',
                                      'Accept-Charset' => 'utf-8',
                                      'User-Agent' => 'Vertebrae REST Gem',
                                      'Content-Type' => 'application/json',
                                      'special-auth-token' => 'abcde12345'})
        expect(opts[:ssl]).to eq({})
        expect(opts[:url]).to eq 'https://example.com/'
      end
    end
  end
end

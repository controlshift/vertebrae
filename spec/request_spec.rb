require 'spec_helper'

describe Vertebrae::Request do
  let(:vb) { Vertebrae::API.new  }
  let(:path) { 'actionkit.api/rest/v1/action' }
  let(:params) { {} }
  let(:options) { {} }

  it "knows how to make get request" do
    expect(vb).to receive(:request).with(:get, path, params, options)
    vb.get_request path, params, options
  end

  it "knows how to make patch request" do
    expect(vb).to receive(:request).with(:patch, path, params, options)
    vb.patch_request path, params, options
  end

  it "knows how to make post request" do
    expect(vb).to receive(:request).with(:post, path, params, options)
    vb.post_request path, params, options
  end

  it "knows how to make put request" do
    expect(vb).to receive(:request).with(:put, path, params, options)
    vb.put_request path, params, options
  end

  it "knows how to make delete request" do
    vb.should_receive(:request).with(:delete, path, params, options)
    vb.delete_request path, params, options
  end

  describe 'it should result in an appropriately configured connection object when it comes time to run transactions' do
    before(:each) do
      logger = double
      logger.stub(:debug).and_return(true)
      allow(Vertebrae::Base).to receive(:logger).and_return(logger)
      allow_any_instance_of(Vertebrae::API).to receive(:default_options).and_return({host: 'test.com'})
    end

    context 'with an empty hash' do
      let(:options) { {} }
      it 'should make the request to the default host' do
        stub_request(:get, 'https://test.com/path')
        vb.request(:get, '/path', {}, options)
      end
    end

    context 'with a different host' do
      let(:options) { {host: 'test2.com'} }
      it 'should make the request to the default host' do
        stub_request(:get, 'https://test2.com/path')
        vb.request(:get, '/path', {}, options)
      end
    end

    context 'with host specified at client initiation time' do
      let(:options) { {} }

      let(:vb) { Vertebrae::API.new host: 'test3.com' }

      it 'should make the request to the default host' do
        stub_request(:get, 'https://test3.com/path')
        vb.request(:get, '/path', {}, options)
      end

      context 'with a different host' do
        let(:options) { {host: 'test2.com'} }
        it 'should make the request to the default host' do
          stub_request(:get, 'https://test2.com/path')
          vb.request(:get, '/path', {}, options)
        end
      end
    end
  end
end

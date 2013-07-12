require 'spec_helper'

describe Vertebrae::Request do
  let(:vb) { Vertebrae::API.new  }
  let(:path) { 'actionkit.api/rest/v1/action' }
  let(:params) { {} }
  let(:options) { {} }

  it "knows how to make get request" do
    vb.should_receive(:request).with(:get, path, params, options)
    vb.get_request path, params, options
  end

  it "knows how to make patch request" do
    vb.should_receive(:request).with(:patch, path, params, options)
    vb.patch_request path, params, options
  end

  it "knows how to make post request" do
    vb.should_receive(:request).with(:post, path, params, options)
    vb.post_request path, params, options
  end

  it "knows how to make put request" do
    vb.should_receive(:request).with(:put, path, params, options)
    vb.put_request path, params, options
  end

  it "knows how to make delete request" do
    vb.should_receive(:request).with(:delete, path, params, options)
    vb.delete_request path, params, options
  end
end
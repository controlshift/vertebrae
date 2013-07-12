require 'spec_helper'

require 'dummy/dummy'
require 'dummy/client'

describe Vertebrae::Authorization do
  let(:options) { {} }

  subject(:vb) { Dummy.new options }

  after do
    reset_authentication_for vb
  end

  context ".authenticated?" do
    it { should respond_to(:authenticated?) }
  end

  context "authentication" do

    context 'username & password' do
      let(:options) { { :username => 'vb', :password => 'pass' } }

      it "should return hash with username & password params" do
        vb.basic_auth.should == "#{options[:username]}:#{options[:password]}"
      end
    end
  end
end # authentication

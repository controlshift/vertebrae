require 'spec_helper'

describe Vertebrae::API do
  subject { described_class.new(options) }

  it { described_class.included_modules.should include Vertebrae::Request }

  describe 'initialize' do
    before(:each) do
      Vertebrae::API.any_instance.stub(:default_options).and_return({content_type: 'foo'})
    end

    context 'with an empty hash' do
      let(:options) { {} }
      specify { expect(subject.connection.options).to eq({content_type: 'foo'}) }
    end

    context 'with a default content-type' do
      let(:options) { {content_type: 'text/csv'} }
      specify { expect(subject.connection.options).to eq({content_type: 'text/csv'}) }
    end
  end

  describe 'dummy' do
    describe 'should delegate to the client class' do
      specify{ Dummy.new.should respond_to(:api)  }
      specify{ Dummy.should respond_to(:api) }
    end
  end
end
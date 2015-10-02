require 'spec_helper'

describe Vertebrae::API do
  subject { described_class.new(options) }

  it { expect(described_class.included_modules).to include Vertebrae::Request }

  describe 'initialize' do
    before(:each) do
      allow_any_instance_of(Vertebrae::API).to receive(:default_options).and_return({content_type: 'foo'})
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
      specify { expect(Dummy.new).to respond_to(:api)  }
      specify { expect(Dummy).to respond_to(:api) }
    end
  end
end

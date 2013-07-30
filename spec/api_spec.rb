require 'spec_helper'

describe Vertebrae::API do

  subject { described_class.new(options) }

  it { described_class.included_modules.should include Vertebrae::Request }

  describe 'dummy' do
    describe 'should delegate to the client class' do
      specify{ Dummy.new.should respond_to(:api)  }
      specify{ Dummy.should respond_to(:api) }
    end
  end
end
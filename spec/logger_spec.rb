require 'spec_helper'

describe 'logging' do
  it "should have a logger" do
    Dummy.respond_to?(:logger).should be_true
  end

  it "should be able to log debug methods" do
    Dummy.logger.respond_to?(:debug).should be_true
  end

  it "should be settable" do
    Dummy.respond_to?(:logger=).should be_true
    log = double()
    Dummy.logger = log
    Dummy.logger.should == log
  end
end

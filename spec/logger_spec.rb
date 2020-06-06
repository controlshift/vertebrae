# frozen_string_literal: true

require 'spec_helper'

describe 'logging' do
  it "should have a logger" do
    expect(Dummy).to respond_to(:logger)
  end

  it "should be able to log debug methods" do
    expect(Dummy.logger).to respond_to(:debug)
  end

  it "should be settable" do
    expect(Dummy).to respond_to(:logger=)
    log = double
    Dummy.logger = log
    expect(Dummy.logger).to eq(log)
  end
end

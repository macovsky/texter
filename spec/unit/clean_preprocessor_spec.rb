require 'spec_helper'

describe Texter::CleanPreprocessor do
  describe '.call' do
    it 'should remove \r from text' do
      body = "\nsome\r\ntext "
      Texter::CleanPreprocessor.call(body).should == "some\ntext"
    end
  end
end

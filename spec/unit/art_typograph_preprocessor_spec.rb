# encoding: UTF-8
require 'spec_helper'

describe Texter::ArtTypographPreprocessor do
  let(:body) { %|- Это "Типограф"?\n\n— Нет, это «Типограф»!| }

  describe '#call' do
    it 'should remove html' do
      ArtTypograph.should_receive(:process).with(body).and_return(%|<p>— Это «Типограф»?</p>\n<p>— Нет, это «Типограф»!</p>|)
      processed = Texter::ArtTypographPreprocessor.call(body)
      processed.should == %|— Это «Типограф»?\n\n— Нет, это «Типограф»!|
    end
  end
end

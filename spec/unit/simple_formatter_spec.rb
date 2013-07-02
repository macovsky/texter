# encoding: UTF-8
require 'spec_helper'

describe Texter::SimpleFormatter do
  let(:text) { "Песня Винни-Пуха" }
  let(:formatter) { Texter::SimpleFormatter.new(text) }

  describe '#inline' do
    it 'should inline html' do
      formatter.inline.should == "Песня Винни-Пуха"
    end
  end

  describe '#block' do
    it 'should return block html' do
      formatter.block.should == "<p>Песня Винни-Пуха</p>"
    end
  end
end

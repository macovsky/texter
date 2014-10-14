# encoding: UTF-8
require 'spec_helper'

describe Texter::TextileFormatter do
  let(:text) { "Песня *Винни-Пуха*" }
  let(:formatter) { Texter::TextileFormatter.new(text) }

  describe '#inline' do
    it 'should inline html' do
      formatter.inline.should == "Песня <strong>Винни-Пуха</strong>"
    end
  end

  describe '#block' do
    it 'should return block html' do
      formatter.block.should == "<p>Песня <strong>Винни-Пуха</strong></p>"
    end
  end
end

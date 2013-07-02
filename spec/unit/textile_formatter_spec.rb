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

  context 'with options' do
    it 'should raise an error when unknown option was passed' do
      expect { Texter::TextileFormatter.new("s", :whatever => true) }.to raise_error
    end

    it 'should set default options' do
      formatter = Texter::TextileFormatter.new("s")
      formatter.options[:rules].should == formatter.rules
      formatter.options[:restrictions].should == formatter.restrictions
    end

    it 'should include passed options' do
      formatter = Texter::TextileFormatter.new("s", :rules => [])
      formatter.options[:rules].should == []
    end
  end
end

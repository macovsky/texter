# encoding: UTF-8
require 'spec_helper'

describe Texter::MarkdownFormatter do
  let(:text) { "Песня *Винни-Пуха*" }
  let(:formatter) { Texter::MarkdownFormatter.new(text) }

  describe '#inline' do
    it 'should inline html' do
      formatter.inline.should == "Песня <em>Винни-Пуха</em>"
    end
  end

  describe '#block' do
    it 'should return block html' do
      formatter.block.should == "<p>Песня <em>Винни-Пуха</em></p>\n"
    end
  end

  context 'with options' do
    it 'should raise an error when unknown option was passed' do
      expect { Texter::MarkdownFormatter.new("s", :whatever => true) }.to raise_error
    end

    it 'should set default options' do
      formatter = Texter::MarkdownFormatter.new("s")
      formatter.options[:extensions].should == formatter.extensions
    end

    it 'should include passed options' do
      formatter = Texter::MarkdownFormatter.new("s", :extensions => [:smart])
      formatter.options[:extensions].should == [:smart]
    end
  end
end

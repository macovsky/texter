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
end

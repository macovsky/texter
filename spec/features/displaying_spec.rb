# encoding: UTF-8
require 'spec_helper'

describe 'displaying' do
  before do
    visit root_path
  end

  it 'displays inline header' do
    find('h1').text.should == 'Песня Винни-Пуха'
  end

  it 'displays block element and formats it with textile' do
    paragraphs = find('#textile div').native.children.map(&:to_s)
    paragraphs.first.should == '<p>Вот <strong>горшок</strong> пустой!</p>'
    paragraphs.last.should == '<p>Он предмет простой!</p>'
  end

  it 'displays block element and formats it with simple_format' do
    paragraphs = find('#simple-format div').native.children.map(&:to_s)
    paragraphs.first.should == '<p>Вот *горшок* пустой!</p>'
    paragraphs.last.should == "<p>Он предмет простой!\n</p>"
  end

  it 'displays text from another locale' do
    find("#switch").text.should == "In English"
  end
end

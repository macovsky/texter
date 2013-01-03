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
    paragraphs = find('#song div').native.children.map(&:to_s)
    paragraphs.first.should == '<p>Вот <strong>горшок</strong> пустой!</p>'
    paragraphs.last.should == '<p>Он предмет простой!</p>'
  end
end

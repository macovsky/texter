# encoding: UTF-8
require 'spec_helper'

describe Texter::Text do
  let(:path) { 'ru.texter._shared.header.title' }
  let(:title) { 'Песня Винни-Пуха' }
  subject {
    text = Texter::Text.new
    text.path = path
    text
  }

  it 'should read i18n text by default' do
    subject.get_body.should == title
  end

  context 'with validation' do
    it 'is valid if path and body were specified' do
      subject.body = "something"
      subject.should be_valid
    end

    it 'is invalid if path was not unique' do
      Texter::Text.find_or_create_by(path: path)
      subject.should_not be_valid
      subject.should have(1).errors_on(:path)
    end
  end

  context '.find_or_initialize_by_path' do
    it 'should get text from i18n on creation' do
      text = Texter::Text.find_or_initialize_by_path(path)
      text.body.should == title
    end

    it 'should fetch same object if it existed' do
      subject.update_attributes(body: 'Новый перевод')
      Texter::Text.find_or_initialize_by_path(path).body.should == 'Новый перевод'
    end
  end
end

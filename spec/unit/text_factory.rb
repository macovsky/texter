require 'spec_helper'

describe Texter::TextFactory do
  def build(*args)
    Texter::TextFactory.new(*args).build
  end

  let(:path) { '_shared.header.title' }
  subject { build(path, :inline, nil) }

  its(:path) { should == path }
  its(:tag_type) { should == :inline }

  context '#build' do
    it 'builds an object with a shortcut' do
      text = build('.title', :inline, '_shared/_header')
      text.path.should == path
    end

    it 'raises an error if virtual path was not available' do
      expect { build('.title', :inline, nil) }.to raise_error
    end
  end
end

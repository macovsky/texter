require 'spec_helper'

describe Texter::BuildText do
  def build(*args)
    Texter::BuildText.call(*args)
  end

  describe '#call' do
    let(:path) { 'pages.index.intro' }

    context 'with absolute path' do
      subject { build(path, :inline, nil, {}) }

      it { should be_a(Texter::Text) }
      its(:path) { should == "ru.texter.pages.index.intro" }
      its(:tag_type) { should == :inline }
    end

    context 'with a relative path' do
      it 'builds a text using virtual path' do
        text = build('.intro', :inline, 'pages/index', locale: :en)
        text.path.should == "en.texter.pages.index.intro"
      end

      it 'raises an error if virtual path was not available' do
        expect { build('.intro', :inline, nil, {}) }.to raise_error
      end
    end
  end
end

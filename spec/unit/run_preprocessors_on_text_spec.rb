# encoding: UTF-8
require 'spec_helper'

describe Texter::RunPreprocessorsOnText do
  let(:body) { %| whatever\n\nthat hurts | }
  let(:typographized_body) { %|<p>whatever</p>\n<p>that hurts</p>| }
  let(:text) { Texter::Text.new(:body => body) }

  before {
    Texter.should_receive(:preprocessors).and_return([:clean, :art_typograph])
    ArtTypograph.should_receive(:process).with(body.strip).and_return(typographized_body)
  }

  describe '#call' do
    it 'should run preprocessors continuosly' do
      Texter::RunPreprocessorsOnText.call(text)
      text.body.should == "whatever\n\nthat hurts"
    end
  end
end

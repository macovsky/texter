# encoding: UTF-8
require 'spec_helper'

describe 'editing', js: true do
  before do
    visit root_path
    @text = 'Песня Муми-Тролля'
  end

  it 'can be edited' do
    find('.ru-texter-_shared-header-title').click
    fill_in 'text_body', with: @text
    click_button 'Сохранить'

    sleep(0.3)

    find('h1').text.should == 'Песня Муми-Тролля'
  end
end

require 'rails_helper'

describe 'my/scrapbooks/index.html.erb' do
  let(:scrapbooks) { Array.new(3) { Fabricate.build(:scrapbook) } }

  describe 'toggle to switch to the memories list' do
    before :each do
      assign(:scrapbooks, scrapbooks)
      render
    end

    it 'displays Memories as not active' do
      expect(rendered).to have_css('.nav.nav-pills li a[href="/my/memories"]')
      expect(rendered).not_to have_css('.nav.nav-pills li.active a[href="/my/memories"]')
    end

    it 'displays Scrapbooks as active' do
      expect(rendered).to have_css('.nav.nav-pills li.active a[href="/my/scrapbooks"]')
    end
  end

  it_behaves_like 'a scrapbook index'
end

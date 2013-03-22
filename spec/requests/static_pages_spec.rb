require 'spec_helper'

describe "StaticPages" do
  subject {page}

  describe "Home Page" do
    before {visit root_path}

    it { should have_selector('h1', text: 'Sample App') }
    it { should have_selector 'title', text: full_title('') }
    it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) {FactoryGirl.create(:user)}
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the users feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end

  end

  describe "Help Page" do
    before { visit help_path}

  	it { should have_content('Help')}
    it { should have_selector 'title', text: full_title('Help') }
  end

  describe "About Page" do
    before {visit about_path}

  	it { should have_content('About Us')}
  	it { should have_selector('title', :text => "About Us")}
  end

  describe "Contact Page" do
    before {visit contact_path}

    it { should have_selector('h1', text: 'Contact')}
    it { should have_selector('title', text: 'Contact')}
  end

end

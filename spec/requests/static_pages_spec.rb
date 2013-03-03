require 'spec_helper'

describe "StaticPages" do

  describe "Home Page" do
    it "should have the content 'Hello'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      page.should have_content('Hello')
    end

    it "shoud have the right title" do
    	visit '/static_pages/home'
    	page.should have_selector('title', :text => " | Home")
    end
  end

  describe "Help Page" do
  	it "should have the content 'Help'" do
  		visit '/static_pages/help'
  		page.should have_content('Help')
  	end

  	it "shoud have the right title" do
    	visit '/static_pages/help'
    	page.should have_selector('title', :text => " | Help")
    end
  end

  describe "About Page" do
  	it "should have the content 'About Us'" do
  		visit '/static_pages/about'
  		page.should have_content('About Us')
  	end

  	it "shoud have the right title" do
    	visit '/static_pages/about'
    	page.should have_selector('title', :text => " | About Us")
    end
  end

end

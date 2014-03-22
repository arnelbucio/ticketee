require 'spec_helper'

feature "Restrict access to admin dashboard" do
  let(:admin) { FactoryGirl.create :admin_user }
  let(:user) { FactoryGirl.create :user }

  scenario "guests can't access the admin dashboard" do
    visit "/admin"
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  scenario "regular users can't access the admin dashboard" do
    sign_in_as!(user)
    visit "/admin"
    expect(page).to have_content("You must be an admin to do that.")
  end

  scenario "admin users can access the admin dashboard" do
    sign_in_as!(admin)
    visit "/admin"

    expect(page).to have_content("Welcome to Ticketee's Admin Lounge. Please enjoy your stay.")
  end
end

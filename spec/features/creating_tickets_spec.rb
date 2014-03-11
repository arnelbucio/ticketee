require 'spec_helper'

feature "Creating Tickets" do
  let!(:project) { FactoryGirl.create :project }
  let(:user) { FactoryGirl.create :user }

  before do
    visit "/"
    click_link project.name
    click_link "New Ticket"
    message = "You need to sign in or sign up before continuing."
    expect(page).to have_content(message)

    fill_in "Name",  with: user.name
    fill_in "Password",  with: user.password
    click_button "Sign in"

    click_link project.name
    click_link "New Ticket"
  end

  scenario "Creating a ticket" do
    fill_in "Title",  with: "Non-standars compliance"
    fill_in "Description",  with: "My pages are ugly"
    click_button "Create Ticket"

    within("#ticket #author") do
      expect(page).to have_content("Created by #{user.email}")
    end

    expect(page).to have_content("Ticket has been created.")
  end

  scenario "Creating a ticket with invalid attributes fails" do
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Title",  with: "Non-standars compliance"
    fill_in "Description",  with: "it sucks"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
end

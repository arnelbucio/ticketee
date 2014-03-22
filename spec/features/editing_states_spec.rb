require 'spec_helper'

feature "Editing states" do
  let!(:state) { FactoryGirl.create :state }

  before do
    sign_in_as!(FactoryGirl.create :admin_user)
  end

  scenario "Editing a state" do
    click_link "Admin"
    click_link "States"
    within state_line_for(state.name) do
      click_link "Edit State"
    end
    fill_in "Name",  with: "Changed!"
    click_button "Update State"
    expect(page).to have_content("State has been updated.")
  end
end

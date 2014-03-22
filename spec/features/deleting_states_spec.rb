require 'spec_helper'

feature "Deleting states" do
  let!(:state) { FactoryGirl.create :state }

  before do
    sign_in_as!(FactoryGirl.create :admin_user)
  end

  scenario "Deleting a state" do
    click_link "Admin"
    click_link "States"
    within state_line_for(state.name) do
      click_link "Delete"
    end

    within("#states") do
      expect(page).to_not have_content(state.name)
    end
    expect(page).to have_content("State has been deleted.")
  end
end

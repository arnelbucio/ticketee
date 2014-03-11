require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create :user }
  let(:project) { FactoryGirl.create :project }
  context "standard users" do
    { new: :get,
      create: :post,
      edit: :get,
      update: :patch,
      destroy: :delete }.each do |action, method|
      it "cannot access the #{action} action" do
        sign_in(user)
        send(method, action, id: project)
        expect(response).to redirect_to('/')
        expect(flash[:alert]).to eql("You must be an admin to do that.")
      end
    end
  end
end

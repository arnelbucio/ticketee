require 'spec_helper'

describe User do
  describe "passwords" do
    it "needs a password and confirmation to save" do
      u = User.new(name: "Arnel")

      u.save
      expect(u).to_not be_valid

      u.password = "password"
      u.password_confirmation = ""
      u.save
      expect(u).to_not be_valid

      u.password_confirmation = "password"
      u.save
      expect(u).to be_valid
    end

    it "needs password and confirmation to match" do
      u = User.create(
            name: "steve",
            password: "password",
            password_confirmation: "password2")
      expect(u).to_not be_valid
    end
  end

  describe "authentication" do
    let(:user) { User.create(
      name: "Arnel",
      password: "password",
      password_confirmation: "password") }

    it "authenticate with a correct password" do
      expect(user.authenticate("password")).to be
    end

    it "doest not authenticate with an incorrect password" do
      expect(user.authenticate("password2")).to_not be
    end
  end
end

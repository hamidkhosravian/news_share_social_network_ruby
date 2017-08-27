require "rails_helper"
RSpec.describe Api::V1::AuthenticationController , type: :controller do
  describe "signup" do
    context "valid" do
      it "email and password" do
        post :signup, params: FactoryGirl.attributes_for(:user)
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r["response"]).to include "login"
        expect(response.code).to eq "201"
        expect(response.request.filtered_parameters["email"]).to eq User.last.email
      end

      it "email taken" do

        post :signup, params: FactoryGirl.attributes_for(:taken_email)
        post :signup, params: FactoryGirl.attributes_for(:taken_email)
        r = JSON.parse(response.body)

        expect(r).not_to be nil
        expect(r["response"]["email"][0]).to include "has already been taken"
        expect(response.code).to eq "400"
      end
    end

    context "unvalid" do

      it "email unvalid" do
        post :signup, params: FactoryGirl.attributes_for(:email_invalid)
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r["response"]["email"][0]).to include "is invalid"
        expect(response.code).to eq "400"

        post :signup, params: FactoryGirl.attributes_for(:email_balnk)
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r["response"]["email"][0]).to include "blank"
        expect(response.code).to eq "400"
      end

      it "password unvalid" do
        post :signup, params: FactoryGirl.attributes_for(:password_invalid)
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r["response"]["password"][0]).to include "short"
        expect(response.code).to eq "400"

        post :signup, params: FactoryGirl.attributes_for(:password_blank)
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r["response"]["password"][0]).to include "blank"
        expect(response.code).to eq "400"
      end

      it "email and password unvalid" do
        post :signup, params: FactoryGirl.attributes_for(:invalid_params)
        r = JSON.parse(response.body)

        expect(r).not_to be nil
        expect(r["response"]["email"][0]).to include "is invalid"
        expect(r).not_to be nil
        expect(r["response"]["password"][0]).to include "short"
        expect(response.code).to eq "400"

        post :signup, params: FactoryGirl.attributes_for(:blank_params)
        r = JSON.parse(response.body)

        expect(r).not_to be nil
        expect(r["response"]["email"][0]).to include "blank"
        expect(r).not_to be nil
        expect(r["response"]["password"][0]).to include "blank"
        expect(response.code).to eq "400"
      end
    end
  end

  describe "signin" do
    it "valid" do

      user = FactoryGirl.attributes_for(:user)
      post :signup, params: user
      post :signin, params: user

      r = JSON.parse(response.body)
      token = r["token"]["token"]

      expect(r).not_to be nil
      expect(r["email"]).to eq user[:email]
      expect(token).to eq User.last.token.token
      expect(response.code).to eq "200"

    end

    it "unvalid" do
      post :signin, params: { email: "dawdawa@eda.as", password: "231eqwda" }

      r = JSON.parse(response.body)
      expect(r).not_to be nil
      expect(r["response"]).to include "Email or Password do not match"
      expect(response.code).to eq "400"
    end
  end
end

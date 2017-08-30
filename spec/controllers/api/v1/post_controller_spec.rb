require "rails_helper"
RSpec.describe Api::V1::PostsController, type: :controller do
  describe "POST /posts" do
    it "return 201 when post is created" do
      token = sign_in_as_registered
      post :create, params: FactoryGirl.attributes_for(:post)
      expect(response).to have_http_status(201)
    end
    it "return 400 when content is empty" do
      token = sign_in_as_registered
      expect do
        post :create, params: FactoryGirl.attributes_for(:post_unvalid)
      end.to raise_error(RailsParam::Param::InvalidParameterError)
    end
  end

  describe "PUT /posts" do
    it "return 200 when content update" do
      token = sign_in_as_registered
      post :create, params: FactoryGirl.attributes_for(:post)
      id = JSON.parse(response.body)["id"]
      put :update, params: { id: id, content: Faker::Lorem.sentence }
      expect(response).to have_http_status(200)
    end

    it "return 200 when attachment update" do
      token = sign_in_as_registered
      post :create, params: FactoryGirl.attributes_for(:post)
      id = JSON.parse(response.body)["id"]
      put :update, params: { id: id, attachment: Faker::Avatar.image }
      expect(response).to have_http_status(200)
    end

    it "return 401 when path is unauthenticated" do
      put :update, params: { id: 1, attachment: Faker::Avatar.image }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

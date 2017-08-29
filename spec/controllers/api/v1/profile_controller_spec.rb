require "rails_helper"
RSpec.describe Api::V1::ProfileController, type: :controller do
  describe "GET /profile" do
    it "return 200 when path is ok" do
      token = sign_in_as_registered
      get :show
      expect(response).to have_http_status(:ok)
    end
    it "return 404 when path is not fount" do
      get :show
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT /profile" do
    it "return 200 when path is ok" do
      token = sign_in_as_registered
      profile = FactoryGirl.attributes_for(:profile)
      put :update, params: profile
      expect(response).to have_http_status(:ok)
    end
    it "return 401 when path is unauthenticated" do
      put :update
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

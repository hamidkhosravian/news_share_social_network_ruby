require "rails_helper"
RSpec.describe Api::V1::RelationshipController, type: :controller do

  it "when follow user" do
    sign_in_as_registered
    other_user = create(:user)
    post :create, params: { user_id: other_user }
    expect(response.status).to eq 200
    expect(current_user.profile.following?(other_user.profile)).to eq true
  end

  it "when unfollow user" do
    sign_in_as_registered
    other_user = create(:user)

    post :create, params: { user_id: other_user }
    expect(response.status).to eq 200
    expect(current_user.profile.following?(other_user.profile)).to eq true

    delete :destroy, params: { user_id: other_user }
    expect(response.status).to eq 204
    expect(current_user.profile.following?(other_user.profile)).to eq false
  end
end

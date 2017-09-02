require "rails_helper"

RSpec.describe Api::V1::VotesController, type: :controller do
  describe "POST /liked" do
    it "return 201 when post is created" do
      token = sign_in_as_registered
      p = create(:post, profile: Profile.last)
      size = p.get_likes.size
      id = p.id
      post :like_post, params: {id: id}
      expect(response).to have_http_status(200)

      p = Post.find(id)
      expect(p.get_likes.size).to eq size+1
    end
  end

  describe "POST /liked" do
    it "return 201 when post is created" do
      token = sign_in_as_registered
      p = create(:post, profile: Profile.last)
      size = p.get_likes.size
      id = p.id

      post :like_post, params: {id: id}
      expect(response).to have_http_status(200)

      p = Post.find(id)
      expect(p.get_likes.size).to eq size+1
      size = p.get_likes.size

      delete :unlike_post, params: {id: id}
      expect(response).to have_http_status(204)

      p = Post.find(id)
      expect(p.get_likes.size).to eq size-1
    end
  end
end

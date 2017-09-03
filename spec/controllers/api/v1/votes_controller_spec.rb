require "rails_helper"

RSpec.describe Api::V1::VotesController, type: :controller do
  describe "when posts" do
    context "POST liked" do
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

    context "Delete unliked" do
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
  describe "when comments" do
    context "POST liked" do
      it "return 201 when comment is created" do
        token = sign_in_as_registered
        p = create(:post, profile: Profile.last)

        comment = create(:comment, profile: Profile.last, post: p)
        size = comment.get_likes.size
        id = comment.id
        post :like_comment, params: {id: id}
        expect(response).to have_http_status(200)

        comment = Comment.find(id)
        expect(comment.get_likes.size).to eq size+1
      end
    end

    context "Delete unliked" do
      it "return 201 when comment is created" do
        token = sign_in_as_registered
        p = create(:post, profile: Profile.last)

        comment = create(:comment, profile: Profile.last, post: p)
        size = comment.get_likes.size
        id = comment.id

        post :like_comment, params: {id: id}
        expect(response).to have_http_status(200)

        comment = Comment.find(id)
        expect(comment.get_likes.size).to eq size+1
        size = comment.get_likes.size

        delete :unlike_comment, params: {id: id}
        expect(response).to have_http_status(204)

        comment = Comment.find(id)
        expect(comment.get_likes.size).to eq size-1
      end
    end
  end
end

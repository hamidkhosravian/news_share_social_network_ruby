module Api
  module V1
    class VotesController < ApiController
      before_action :authenticate_user_from_token!

      def like_post
        post = Post.find(params[:id])
        post.liked_by current_user
        render json: {response: "like post.", status: 200 }
      end

      def unlike_post
        post = Post.find(params[:id])
        post.unliked_by current_user
        render json: {response: "unlike post.", status: 204}, status: 204
      end
    end
  end
end

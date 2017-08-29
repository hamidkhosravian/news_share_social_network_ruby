module Api
  module V1
    class PostsController < ApiController
      before_action :authenticate_user_from_token!
      load_and_authorize_resource only: [:update, :destroy]

      def create
        post = PostService.new(params, current_user).register
        render json: PostSerializer.new(post[:post])
      end

      def update
        param! :content, String, required: false, blank: false

        post = Post.find(params[:id])
        post.content = params[:content] unless params[:content].nil?
        post.save!

        render json: post
      end
    end
  end
end

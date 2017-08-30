module Api
  module V1
    class PostsController < ApiController
      before_action :authenticate_user_from_token!
      load_and_authorize_resource only: [:update, :destroy]

      def show
        post = Post.find(params[:id])
        if post.profile.eql?(current_user.profile)
          render json: post, serializer: PostOwnerSerializer
        else
          render json: post
        end
      end

      def create
        post = PostService.new(params, current_user).register
        render json: post[:post]
      end

      def update
        param! :content, String, required: false, blank: false

        post = Post.find(params[:id])
        post.content = params[:content] unless params[:content].nil?
        post.attachment = params[:attachment]
        post.save!

        render json: post
      end
    end
  end
end

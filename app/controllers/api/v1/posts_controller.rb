module Api
  module V1
    class PostsController < ApiController
      before_action :authenticate_user_from_token!
      load_and_authorize_resource only: [:update, :destroy]
      impressionist actions: [:show]

      def show
        post = Post.find(params[:id])
        if post.profile.eql?(current_user.profile)
          render json: post, serializer: PostOwnerSerializer
        else
          render json: post
        end
      end

      def create
        param! :content, String, required: true, blank: false
        param! :latitude, String, required: true, blank: false
        param! :longitude, String, required: true, blank: false

        post = PostService.new(params, current_user).create
        render json: post[:post], status: 201
      end

      def update
        param! :content, String, required: false, blank: false

        post = Post.find(params[:id])
        post.content = params[:content] unless params[:content].nil?
        post.attachment = params[:attachment]
        post.categories = Category.find(params[:categories]) if params[:categories]
        post.save!

        render json: post
      end

      def destroy
        Post.find(params[:id]).destroy
      end
    end
  end
end

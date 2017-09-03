module Api
  module V1
    class CommentsController < ApiController
      before_action :authenticate_user_from_token!
      load_and_authorize_resource only: [:destroy]

      def index
        comments = Post.find(params[:id]).comments
        render json: comments, status: 200
      end

      def show
        comment = Comment.find(params[:id])
        render json: comment, status: 200
      end

      def create
        param! :content, String, required: true, blank: false

        post = Post.find(params[:id])
        comment = CommentService.new(params, current_user, post).create
        render json: comment[:comment], status: 201
      end

      def destroy
        Comment.find(params[:id]).destroy
      end
    end
  end
end

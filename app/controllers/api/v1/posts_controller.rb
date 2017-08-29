module Api
  module V1
    class PostsController < ApiController
      before_action :authenticate_user_from_token!

      def create
        post = PostService.new(params, current_user).register
        render json: PostSerializer.new(post[:post])
      end
    end
  end
end

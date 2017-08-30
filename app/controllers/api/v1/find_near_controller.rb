module Api
  module V1
    class FindNearController < ApiController
      before_action :authenticate_user_from_token!

      def posts
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10
        param! :distance, Integer, default: 8
        param! :latitude, Float, required: true, blank: false
        param! :longitude, Float, required: true, blank: false

        posts = Post.near([params[:latitude],params[:longitude]],params[:distance]).order("created_at DESC").page(params[:page]).per(params[:limit])

        render json: posts, adapter: :json, each_serializer: PostSerializer, meta: pagination_dict(posts)
      end
    end
  end
end

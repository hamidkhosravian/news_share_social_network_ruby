module Api
  module V1
    class PopularsController < ApiController
      before_action :authenticate_user_from_token!

      def discussed
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10
        param! :days_ago, Integer, default: 1, max: 30
        param! :distance, Integer, default: 8, max: 20, min: 3
        param! :latitude, Float, required: true, blank: false
        param! :longitude, Float, required: true, blank: false

        posts = Post.where("comments_count > ?", 0).where("created_at >= ?",  params["days_ago"].day.ago.utc)
                     .order("comments_count DESC").near([params[:latitude],params[:longitude]],params[:distance])
                     .page(params[:page]).per(params[:limit])

        render json: posts, adapter: :json, each_serializer: PostSerializer, meta: pagination_dict(posts)
      end

      def liked
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10
        param! :days_ago, Integer, default: 1, max: 30
        param! :distance, Integer, default: 8, max: 20, min: 3
        param! :latitude, Float, required: true, blank: false
        param! :longitude, Float, required: true, blank: false

        posts = Post.where("cached_votes_up > ?", 0).where("created_at >= ?",  1.day.ago.utc).order("cached_votes_up ASC")
                     .near([params[:latitude],params[:longitude]],params[:distance])
                     .page(params[:page]).per(params[:limit])

        render json: posts, adapter: :json, each_serializer: PostSerializer, meta: pagination_dict(posts)
      end
    end
  end
end

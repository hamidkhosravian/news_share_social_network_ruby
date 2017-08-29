module Api
  module V1
    class RelationshipController < ApiController
      before_action :authenticate_user_from_token!

      def create
        profile = User.find(params[:user_id]).profile
        unless current_user.id.eql?(params[:user_id].to_i)
          current_user.profile.follow(profile.id)
          render json: {response: "user followed", status: 200}, status: 200
        end
      end

      def destroy
        relationship = Relationship.find_by(follower_id: current_user.profile.id)
        if relationship 
          profile = relationship.followed
          current_user.profile.unfollow(profile.id)
          render json: {response: "user unfollowed", status: 204}, status: 204
        end
      end
    end
  end
end

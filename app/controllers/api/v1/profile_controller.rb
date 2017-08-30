module Api
  module V1
    class ProfileController < ApiController
      before_action :authenticate_user_from_token!

      def update
        param! :name, String, required: true, blank: false
        param! :birthday, Date, required: false, blank: false
        param! :gender, String, required: false, blank: false
        param! :summery, String, required: false, blank: false

        current_user.profile.name = params[:name]
        current_user.profile.summery = params[:summery] unless params[:summery].nil?
        current_user.profile.gender = params[:gender] unless params[:gender].nil?
        current_user.profile.birthday = params[:birthday] unless params[:birthday].nil?

        current_user.profile.save!
        render json: current_user.profile
      end

      def upload_avatar
        current_user.profile.avatar = params[:avatar]
        current_user.profile.save!
        render json: current_user.profile, status: 201
      end

      def show
        render json: current_user.profile
      end

      def show_profile
        param! :user_id, Integer, required: true, blank: false
        profile = User.find(params[:user_id]).profile
        render json: profile, serializer: FullDetailProfileSerializer
      end
    end
  end
end

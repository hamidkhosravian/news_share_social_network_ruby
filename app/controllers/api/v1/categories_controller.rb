module Api
  module V1
    class CategoriesController < ApiController
      before_action :authenticate_user_from_token!
      
      def index
        categories = Category.all
        render json: categories
      end
    end
  end
end

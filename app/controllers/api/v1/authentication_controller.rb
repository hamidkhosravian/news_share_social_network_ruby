module Api
  module V1
    class AuthenticationController < ApiController
      def signin
        user = login_user!(params[:email], params[:password])
        render json: user, status: user[:status]
      end

      def logout
        logout_user!
      end

      def refresh_token
        user = refresh_user!(params[:refresh_token])
        render json: user, status: user[:status]
      end

      def forgot_password
        user = User.find_by(email: params[:email])
        if user
          result = user.send_reset_password_instructions
          render json: { email: user.email, response: "Your password reset instructions have been sent. Please check your email."  }.to_json , status: :ok
        else
          render json: { response: "Your email is wrong" }.to_json , status: :bad_request
        end
      end

      def reset_password
        reset_password_token = Devise.token_generator.digest(User, :reset_password_token, params[:token])
        user = User.where(reset_password_token: reset_password_token).first

        raise BadRequestError, "Invalid reset password token" unless user.present?
        raise BadRequestError, "Invalid password" if params[:new_password].present? && params[:new_password_confirmation] == params[:new_password]

        user.password = params[:new_password]
        user.password_confirmation = params[:new_password_confirmation]
        user.reset_password_token = nil
        result = user.save

        if result
          render json: { email: user.email, response: "Password reset." }.to_json , status: :ok
        else
          errors = user.errors
          render json: { response: errors  }.to_json , status: :bad_request
        end
      end

      def change_password
        authenticate!
        raise AuthError if current_user[:status] == 401
        raise BadRequestError, "Invalid old password" unless current_user.valid_password?(params[:old_password])

        # error!('User not found', 404) if not current_user
        current_user.password = params[:password]
        current_user.password_confirmation = params[:password_confirmation]
        result = current_user.save
        errors = current_user.errors

        if result
          render json: { email: current_user.email, response: "Password change." }.to_json , status: :ok
        else
          render json: { response: errors  }.to_json , status: :bad_request
        end
      end

      def signup
        user = UserService.new(params).register
        if user[:result]
          render json: { response: "You can login right now" }, status: :created
        else
          render json: { response: user[:errors]  }.to_json , status: :bad_request
        end
      end
    end
  end
end

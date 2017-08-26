class ApplicationController < ActionController::API

  rescue_from JWT::ExpiredSignature, with: :render_jwt_time_out
  rescue_from AuthError, with: :render_jwt_auth_error
  rescue_from BadRequestError, with: :render_bad_request_error


  protected
    def render_jwt_time_out
      render json: Helpers::ErrorHelper.error!(I18n.t("messages.authentication.timeout"), 401), status: 401
    end

    def render_jwt_auth_error
      render json: Helpers::ErrorHelper.error!(I18n.t("messages.http._401"), 401), status: 401
    end

    def render_bad_request_error(error)
      render json: Helpers::ErrorHelper.error!(error, 400), status: 400
    end
end

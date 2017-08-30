class ApplicationController < ActionController::API

  rescue_from JWT::ExpiredSignature, with: :render_jwt_time_out
  rescue_from CanCan::AccessDenied, with: :render_cancancan
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from AuthError, with: :render_jwt_auth_error
  rescue_from BadRequestError, with: :render_bad_request_error
  rescue_from ServerError, with: :render_server_error

  protected
    def render_jwt_time_out
      render json: Helpers::ErrorHelper.error!(I18n.t("messages.authentication.timeout"), 401), status: 401
    end

    def render_cancancan(error)
      render json: Helpers::ErrorHelper.error!(error, 401), status: 401
    end

    def render_jwt_auth_error
      render json: Helpers::ErrorHelper.error!(I18n.t("messages.http._401"), 401), status: 401
    end

    def render_record_invalid(error)
      render json: Helpers::ErrorHelper.error!(error, 400), status: 400
    end

    def render_bad_request_error(error)
      render json: Helpers::ErrorHelper.error!(error, 400), status: 400
    end

    def render_server_error
      render json: Helpers::ErrorHelper.error!("server error", 500), status: 500
    end
end

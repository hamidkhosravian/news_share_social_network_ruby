require "auth_service"

module Helpers::AuthHelper
  # login a user with given email and password
  # this method will generate token and refresh token automatically
  # Params:
  # +email+: email address
  # +password+: password
  # +env+: request header
  # ==== Examples
  # user = login_user!('test@test.com', 'test', request.headers)
  # user.token            # => eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJhdXRoX3R
  # user.refresh_token    # => ab9239a532e59a164e1e9a319d5c
  def login_user!(email, password)
    user = ::User.where(email: email).first
    # invalid email
    raise BadRequestError.new(I18n.t("messages.authentication.login.email_password_mismatch")) if user.nil?
    # check if email andd password is valid
    if user && user.valid_password?(password)
      create_token user
      return user
    else
      # invalid email and passowrd
      raise I18n.t("messages.authentication.login.email_password_mismatch")
    end
  end

  # generate a refresh token for user
  # Params:
  # +token+: refresh token
  # +env+: request header
  # ==== Examples
  # user - refresh_user!('1232sadf2342134', request.headers)
  # user.token          # => eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJhdXBSoS
  # user.refresh_token  # => asdfe4trsdfgsdfwqrdfgs43534
  def refresh_user!(token)
    auth_token = AuthToken.where(refresh_token: token).first
    # invalid refresh token
    raise BadRequestError.new(I18n.t("messages.authentication.login.refresh_token")) if auth_token.nil?
    # refresh token expires
    if auth_token.refresh_token_expires_at.nil? || auth_token.refresh_token_expires_at > Time.now
      user = auth_token.tokenable
      create_token user
      return user
    else
      raise AuthError.new(I18n.t("messages.authentication.login.refresh_token"))
    end
  end

  # invalidate all session
  def logout_user!
    user_id = ::AuthService.new(request).destroy_session!
    user = ::User.includes(:auth_tokens).find_by_id(user_id)
    user.invalidate_auth_token
  end

  def authorize!(*args)
    message, code = extract_custom_http_message_code(*args)
    ability = ::Ability.new(current_user)
    ability.authorize!(*args)

    rescue CanCan::AccessDenied => ex
      Helpers::ErrorHelper.error!(message, code)
  end

  # authenticate current request
  def authenticate!
    @current_user = ::AuthService.new(request).authenticate_user!
  end

  # return current authenticated user
  def current_user
    @current_user
  end

  def extract_custom_http_message_code(*args)
    custom_message = args[2][:message] if args[2].present? && args[2][:message].present?
    custom_code = args[2][:code] if args[2].present? && args[2][:code].present?
    message = custom_message ||= I18n.t("messages.http._403")
    code = custom_code ||= 403
    return message, code
  end

  private

    # create new token for user
    # this method will invalidate last token
    def create_token(user)
      user.invalidate_auth_token
      user.generate_auth_token
      user.update_tracked_fields(request.env)
      user.save!
    end
end

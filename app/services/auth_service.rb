require "auth_token_service"

# authentication Service
# use JWT
class AuthService
  attr_reader :request
  attr_reader :auth_token

  # constructor of class
  # @param request [Request]
  def initialize(request)
    @request = request
    @auth_token = request.headers["Authorization"]
  end

  # check user token
  def authenticate_user!
    raise AuthError if !valid_to_proceed?
    @current_user = ::User.find(decoded_auth_token[:user_id])
    @current_user
  end

  # destory user token
  def destroy_session!
    raise AuthError if !valid_to_logout?
    return decoded_auth_token[:user_id]
  end

  private
    # check user has access or not to logout
    def valid_to_logout?
      http_auth_token && decoded_auth_token && decoded_auth_token[:user_id] && valid_token?
    end

    # check user has access or not for a request
    def valid_to_proceed?
      http_auth_token && decoded_auth_token && decoded_auth_token[:user_id] && valid_token?
    end

    # check user token and validation of token
    def valid_token?
      ::AuthToken.where(tokenable_id: decoded_auth_token[:user_id], tokenable_type: :User).newer.first.token == http_auth_token
    end

    # decode the token and return the response
    def decoded_auth_token
      @decoded_auth_token ||= ::AuthTokenService.decode(http_auth_token)
    end

    # get token from Authorization in header
    def http_auth_token
      if auth_token.present?
        if auth_token.split(" ").first.downcase == "bearer"
          @http_auth_token ||= auth_token.split(" ").last
        elsif Rails.env.development? && auth_token.split(" ").first.downcase == "basic"
          @http_auth_token = Base64.decode64(auth_token.split(" ").last)
        end
      end
    end
end

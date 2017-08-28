module ControllerHelpers
  def sign_in_as_registered(user = nil)
    @_current_user = user || create(:user)
    @_current_user.generate_auth_token
    @_current_user.save!

    request.headers["Authorization"] = "Bearer " + current_user.token.token
  end

  def sign_out
    @_current_user = nil
    request.headers["Authorization"] = nil
  end

  def signed_in_headers
    { Authorization: @_current_user.token.token }
  end

  def current_user
    @_current_user
  end
end

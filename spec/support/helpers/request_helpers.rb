module RequestHelpers
  def sign_in_as_registered(user = nil)
    @_current_user = user || create(:user)
    @_current_user.generate_auth_token
    @_current_user.save!
  end

  def current_user
    @_current_user
  end

  def signed_in_headers
    { Authorization: @_current_user.token.token }
  end
end

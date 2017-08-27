class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]
    @user = UserService.find_for_oauth(request, auth, current_user)
    if @user.persisted?
      render json: @user
    else
      render json: @user
    end
  end

  def twitter
    auth = request.env["omniauth.auth"]
    @user = UserService.find_for_oauth(request, auth, current_user)
    if @user.persisted?
      render json: @user
    else
      render json: @user
    end
  end

  def google_oauth2
    auth = request.env["omniauth.auth"]
    @user = UserService.find_for_oauth(request, auth, current_user)
    if @user.persisted?
      render json: @user
    else
      render json: @user
    end
  end

  def failure
    raise AuthError
  end
end

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    auth = request.env["omniauth.auth"]
    @user = UserService.find_for_oauth(request, auth, current_user)
    if @user.persisted?
      render json: @user
    else
      render json: @user
    end
  end

  def twitter
    byebug
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    auth = request.env["omniauth.auth"]
    @user = UserService.find_for_oauth(request, auth, current_user)
    if @user.persisted?
      render json: @user
    else
      render json: @user
    end
  end

  def failure
    byebug
    redirect_to root_path
  end
end

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      #authentication url
      post   "signin" => "authentication#signin"
      post   "signup" => "authentication#signup"
      post   "refresh_token" => "authentication#refresh_token"
      delete "logout" => "authentication#logout"
      put    "forgot_password" => "authentication#forgot_password"
      put    "reset_password"  => "authentication#reset_password"
      put    "change_password" => "authentication#change_password"

      get    "profile" => "profile#show"
      get    "profile/:user_id" => "profile#show_profile"
      put    "profile" => "profile#update"
      post   "profile/upload_avatar" => "profile#upload_avatar"
    end
  end

end

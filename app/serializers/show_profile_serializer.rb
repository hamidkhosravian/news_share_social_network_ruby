class ShowProfileSerializer < ProfileSerializer
  attributes :followed

  def followed
    current_user.profile.following?(object)
  end
end

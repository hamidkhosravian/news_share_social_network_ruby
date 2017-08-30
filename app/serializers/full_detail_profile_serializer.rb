class FullDetailProfileSerializer < ProfileSerializer
  attributes :followed, :summery, :gender, :birthday

  def followed
    current_user.profile.following?(object)
  end
end

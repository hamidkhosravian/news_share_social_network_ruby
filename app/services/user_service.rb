# user Service
# user registeration or other staff
class UserService
  # constructor of class
  def initialize(params)
    @params = params
  end

  # register user
  # if every thing was fine user saved in database
  # if somthing was wrong return error
  def register
    result = true
    errors = nil
    user = nil

    ::User.transaction do
      user = ::User.new
      user.email = @params[:email]
      user.password = @params[:password]
      user.save
      errors = user.errors.messages
      result = false if errors.present?
    end

    { result: result, user: user, errors: errors }
  end


  def self.find_for_oauth(request, auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      if user.nil?
        user = User.new(
          email: email ? email : "#{auth.info.name.delete(' ')}-#{auth.uid}@#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        byebug
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end

    create_token(user, request)
    user
  end

  private
   def self.create_token(user, request)
     user.invalidate_auth_token
     user.generate_auth_token
     user.update_tracked_fields(request.env)
     user.save!
   end
end

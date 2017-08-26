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
end

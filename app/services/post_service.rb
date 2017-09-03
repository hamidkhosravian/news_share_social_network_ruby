# post Service
# post registeration or other staff
class PostService
  # constructor of class
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  # register post
  # if every thing was fine post saved in database
  # if somthing was wrong return error
  def create
    result = true
    errors = nil
    post = nil

    ::Post.transaction do
      post = ::Post.new
      post.content = @params[:content]
      post.latitude = @params[:latitude]
      post.longitude = @params[:longitude]
      post.attachment = @params[:attachment]
      post.categories << Category.find(@params[:categories]) if @params[:categories]
      post.profile_id = @current_user.profile.id
      post.save
      errors = post.errors.messages
      result = false if errors.present?
    end

    { result: result, post: post, errors: errors }
  end
end

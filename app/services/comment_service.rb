# comment Service
# comment registeration or other staff
class CommentService
  # constructor of class
  def initialize(params, current_user, post)
    @params = params
    @current_user = current_user
    @post = post
  end

  # register comment
  # if every thing was fine comment saved in database
  # if somthing was wrong return error
  def create
    result = true
    errors = nil
    comment = nil

    ::Comment.transaction do
      comment = ::Comment.new
      comment.content = @params[:content]
      comment.profile_id = @current_user.profile.id
      comment.post_id = @post.id
      comment.save
      errors = comment.errors.messages
      result = false if errors.present?
    end

    { result: result, comment: comment, errors: errors }
  end
end

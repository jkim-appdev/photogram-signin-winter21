class CommentsController < ApplicationController
  def index
    comments = Comment.all.order({ :created_at => :asc})

    render({ :json => comments.as_json})
  end

  def show
    the_id = params.fetch( :the_comment_id)
    comment = Comment.where({ :id => the_id}).at(0)

    render({ :json => comment.as_json})
  end

  def create
    comment = Comment.new

    comment.author_id = session.fetch( :user_id)
    comment.photo_id = params.fetch("input_photo_id")
    comment.body = params.fetch("input_body")

    comment.save

    redirect_to("/photos/#{comment.photo_id}")
  end


end

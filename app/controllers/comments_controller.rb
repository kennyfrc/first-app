class CommentsController < ApplicationController
  def create
     @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:post_id])
     @comment = @post.comments.build(comment_params)
     @comments = @post.comments.all

     if @comment.save
       flash[:notice] = "Comment was saved."
       render 'posts/show'
     else
       flash[:error] = "There was an error saving the comment. Please try again."
       render 'posts/show'
     end

  end

   private

   def comment_params
     params.require(:comment).permit(:body, :user_id)
   end
end


# reasoned that tiven that @post inherently has current_user due to post#create method, then we don't have to build in current_user
# reasoned that in order for the comments to be 'pre-filtered vs posts', you have to use @post.comments.all?
# reasoned that since we have to go back to the original show page, then render posts/show
class CommentsController < ApplicationController
  def create
     @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:post_id])
     @comment = @post.comments.build(comment_params)
     @comment.user = current_user
     @comments = @post.comments.all

     if @comment.save
       flash[:notice] = "Comment was saved."
       redirect_to [@topic, @post]
     else
       flash[:error] = "There was an error saving the comment. Please try again."
       render 'posts/show'
     end

  end

    def destroy
     @topic = Topic.find(params[:topic_id])
     @post = @topic.posts.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
     logger.debug "Comment is #{@comment}"
 
     authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
       redirect_to [@topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       redirect_to [@topic, @post]
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
# debugging... bad code or bad data?
# reset the database or do it manually in the console...
# databaseditors: SQLliteexplorer
# redirect_to refreshes the instance variables... render does not... so some of the data is still there if you just render
# advisable to do a redirect_to for an error...
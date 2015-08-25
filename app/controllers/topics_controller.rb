class TopicsController < ApplicationController
  def index
    @topics = Topic.order_by(:created_at => 'desc').paginate(page: params[:page])
  end  

  def view
    @topic = Topic.find(params[:id])
    @comments = @topic.comments.where(parent_id: nil).paginate(page: params[:page])
  end

  def new
  end

  def create
    begin
      @topic = Topic.build(topic_params)
      redirect_to show_topic_url(@topic)
    rescue => exception
      @error = exception.error
      render action: :view
    end
  end

  def comment
    begin
      @comment = Comment.build(comment_params)
      @topic = @comment.topic
      redirect_to show_topic_url(@topic, page: params[:page])
    rescue => exception
      @error = exception.error
      @topic = Topic.find(comment_params[:topic_id])
      @comments = @topic.comments.where(parent_id: nil).paginate(page: params[:page])
      render :view
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:subject, :body, :user_id)
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :topic_id, :parent_id)
  end
end

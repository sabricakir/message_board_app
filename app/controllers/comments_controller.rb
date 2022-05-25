class CommentsController < ApplicationController
    before_action :find_message
    before_action :find_comment, only: [:edit, :update, :destroy]
    before_action :authenticate_user!

    def create
        @comment = @message.comments.create(comment_params)
        @comment.user_id = current_user.id
        respond_to do |format|
        if @comment.save
            format.html { redirect_to message_path(@message), :notice => 'Comment was successfully created !' } 
        else
            render 'new'
        end
    end
    end

    def edit
        
    end

    def update
        respond_to do |format|
        if @comment.update(comment_params)
            format.html { redirect_to message_path(@message), :notice => 'Comment was successfully updated !' } 
        else
            render 'edit'
        end
    end
    end

    def destroy
        respond_to do |format|
            @comment.destroy
                format.html { redirect_to message_path(@message), :notice => 'Comment was successfully deleted !' } 
            end
    end

    private

      def comment_params
        params.require(:comment).permit(:content)
      end

      def find_message
        @message = Message.find(params[:message_id])
      end

      def find_comment
        @comment = @message.comments.find(params[:id])
      end
end



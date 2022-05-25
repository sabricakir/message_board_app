class MessagesController < ApplicationController
    before_action :find_message, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    def index
        @messages = Message.all.order("created_at DESC")
    end
    
    def new
        @message = current_user.messages.build
    end
    
    def show
        
    end
    
    def create
        @message = current_user.messages.build(message_params)
        respond_to do |format|
        if @message.save
            format.html { redirect_to root_path, :notice => 'Message was successfully created !' } 
        else
            render 'new'
        end
    end
    end

    def edit
    end

    def update
        respond_to do |format|
        if @message.update(message_params)
            format.html { redirect_to root_path, :notice => 'Message was successfully updated !' } 
        else
            render 'edit'
        end
    end
    end

    def destroy
        respond_to do |format|
        @message.destroy
            format.html { redirect_to root_path, :notice => 'Message was successfully deleted !' } 
        end
    end
    
    private

    def message_params
        params.require(:message).permit(:title, :description)
    end

    def find_message
        @message = Message.find(params[:id])
    end
end

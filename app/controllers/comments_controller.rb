class CommentsController < ApplicationController
    def create
      @provider = Provider.find(params[:provider_id])
      @comment = @provider.comments.build(params[:comment])
      @comment.user_id = current_user.id
      @comment.save!
      redirect_to provider_path(@provider)
    end
end

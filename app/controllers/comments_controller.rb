class CommentsController < ApplicationController
  include UrlHelper

  before_action :find_app
  before_action :find_err

  def create
    @comment = Comment.create(params.require(:comment).permit!.merge(user: current_user, err: @err))
    if @comment.persisted?
      flash[:success] = "Comment saved!"
    else
      flash[:error] = "I'm sorry, your comment was blank! Try again?"
    end
    redirect_to app_err_path(@app, @err)
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params.require(:comment).permit!)
    if @comment.valid?
      @err.comments << @comment
      @err.save
      flash[:success] = "Comment saved!"
    else
      flash[:error] = "I'm sorry, your comment was blank! Try again?"
    end
    redirect_to app_err_path(@app, @err)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted!"
    else
      flash[:error] = "Sorry, I couldn't delete your comment for some reason. I hope you don't have any sensitive information in there!"
    end
    redirect_to app_err_path(@app, @err)
  end

  protected

    def find_app
      @app = App.find(params[:app_id])

      # Mongoid Bug: could not chain: current_user.apps.find_by_id!
      # apparently finding by 'watchers.email' and 'id' is broken
      raise(ActiveRecord::RecordNotFound.new(App,@app.id)) unless current_user.admin? || current_user.watching?(@app)
    end

    def find_err
      @err = @app.errs.find(params[:err_id])
    end

end

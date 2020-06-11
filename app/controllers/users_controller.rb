class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @tracked_stock = @user.stocks
  end

  def my_portfolio
    @tracked_stock = current_user.stocks
    @user = current_user
  end

  def my_friends
    @user_friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @users = User.search(params[:friend])
      @users = current_user.except_current_user(@users)
      if @users
        respond_to do |format|
          format.js{ render partial: 'users/friend_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find users"
          format.js{ render partial: 'users/friend_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a name to search"
        format.js{ render partial: 'users/friend_result'}
      end
    end
  end


end

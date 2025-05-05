class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
  end
  def show
    @user = User.find(params[:id])
  end

  def edit
  end
end

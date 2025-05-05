class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
  end
  def show
    @user = User.find(params[:id])  # そのユーザー情報を取得
    @books = @user.books  # ユーザーが投稿した本を取得
  end

  def edit
  end
end

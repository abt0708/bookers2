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
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      # ユーザー情報更新後、bookのindexページにリダイレクト
      redirect_to books_path
    else
      render :edit
    end
  end

    private
    def user_params
      params.require(:user).permit(:name, :image, :introduction)
    end

end

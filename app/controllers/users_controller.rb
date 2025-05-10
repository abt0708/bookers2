class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
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
    flash[:notice] = "You have updated user successfully."  # フラッシュメッセージを追加
    redirect_to books_path  # 本の一覧ページにリダイレクト
  else
    render :edit  # 更新に失敗した場合は編集ページに戻る
  end
end

    private
    def user_params
      params.require(:user).permit(:name, :image, :introduction)
    end

    def is_matching_login_user
      user = User.find(params[:id])
      redirect_to edit_user_path(current_user) unless user == current_user
      end

end

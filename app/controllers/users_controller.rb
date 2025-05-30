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
    redirect_to user_path(@user)  # ユーザ詳細ページ
  else
    render :edit  # 更新に失敗した場合は編集ページに戻る
  end
end

    private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def is_matching_login_user
      user = User.find(params[:id])
      unless user == current_user
        redirect_to user_path(current_user)
      end
    end
end

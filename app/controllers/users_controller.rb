class UsersController < ApplicationController
  def index
    @users = User.all  # すべてのユーザーを取得
  end
  def show
    @user = User.find(params[:id])
  end

  def edit
  end
end

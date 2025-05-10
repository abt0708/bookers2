class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = @book.user.books  # 投稿者の投稿だけ取得
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params) # 本の更新
      # フラッシュメッセージを設定
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)  # 更新後は詳細ページにリダイレクト
    else
      render :edit # 更新が失敗した場合、編集ページに戻る
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book was successfully deleted."
  end


  def new
    @book = Book.new
  end

  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id  # userとの紐付け
    if @book.save
      # フラッシュメッセージを設定
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)  # 投稿ページへリダイレクト
    else
      @books = Book.all
      render :index  # 投稿が失敗した場合、indexページに戻る
    end
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
end

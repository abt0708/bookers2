class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @books = Book.all
    @book = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params) # 本の更新
      redirect_to book_path(@book), notice: "Book was successfully updated."
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

  # 以下を追加
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id  # userとの紐付け
    if @book.save
      redirect_to book_path(@book), notice: "Book was successfully created."
    else
      @books = Book.all
      render :index
    end
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end

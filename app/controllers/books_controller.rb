class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @books = Book.all
    @book = Book.new
  end

  def edit
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

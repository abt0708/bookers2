class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
  end

  def edit
  end

  def new
    @book = Book.new
  end

  # 以下を追加
  def create
    book = Book.new(list_params)
    Book.save
    render :index
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end

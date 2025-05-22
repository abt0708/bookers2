class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    if request.referer&.include?(book_path(book))
      redirect_to book_path(book)   # 詳細画面からのリクエストなら詳細画面に戻す
    else
      redirect_to books_path        # それ以外は一覧画面へ
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy if favorite
    if request.referer&.include?(book_path(book))
      redirect_to book_path(book)
    else
      redirect_to books_path
    end
  end
end

class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    referer = request.referer
    if referer&.include?(book_path(book))
      redirect_to book_path(book)   # 詳細画面からのリクエスト
    elsif referer&.include?(user_path(current_user))
      redirect_to user_path(current_user)  # ユーザ詳細画面からのリクエスト
    else
      redirect_to books_path         # それ以外は一覧画面
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy if favorite
    referer = request.referer
    if referer&.include?(book_path(book))
      redirect_to book_path(book)
    elsif referer&.include?(user_path(current_user))
      redirect_to user_path(current_user)
    else
      redirect_to books_path
    end
  end 
end

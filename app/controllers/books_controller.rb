class BooksController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @new_book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(current_user.id)
    @new_book = Book.new
    @book = Book.find(params[:id])
  end

  def create
    @user = User.find(current_user.id)
    @books = Book.all
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:create] = "You have created book successfully."
      redirect_to book_path(@new_book.id)
    else
      render :index
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:book_update] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

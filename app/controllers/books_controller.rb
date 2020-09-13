class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_book,{only:[:edit]}

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully saved."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
  	@books = Book.all
    @user = current_user
    @book = Book.new
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  def show
    @book =Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def edit
   @book = Book.find(params[:id])
  end


  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def authenticate_book
    book=Book.find(params[:id])
    if book.user_id != current_user.id
      redirect_to books_path
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end

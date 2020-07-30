class BooksController < ApplicationController

before_action :authenticate_user!

   def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create

  	@book = Book.new(books_params)

    @book.user_id = current_user.id

  	if @book.save
      flash[:notice]="You have creatad book successfully."
  	  redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end


  def show
    @user = current_user
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      render "edit"
     else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(books_params)
    flash[:notice]="You have updated book successfully."
    redirect_to book_path(@book)
    else
      #@book = Book.find(params[:id])
      render :edit
    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def books_params
    params.require(:book).permit(:title, :body)
  end

end

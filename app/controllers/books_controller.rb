class BooksController < ApplicationController
  
  def index
    @user = current_user
    @books = @user.books
    @tags = @user.tags
  end
  
  def new
    @user = User.find(params[:user_id])
    sign_in(@user)
    @book = Book.new(title:"")
  end
  
  def create
    @book =Book.new(title: params[:book][:title], 
            proper_title: params[:book][:proper_title], price: params[:book][:price], author: params[:book][:author], image: params[:book][:image],memo: params[:book][:memo],
            summary: params[:book][:summary], related_videos: params[:book][:related_videos], favorite: params[:book][:favorite], own: params[:book][:own], 
            user_id: "#{params[:user_id]}")
      if @book.save
        flash[:success] = "追加しました"
        redirect_to books_path
        # flash表示
      end
  end
  
  def show
  end
  
  def edit
  end
  
  def delete
  end
  
end

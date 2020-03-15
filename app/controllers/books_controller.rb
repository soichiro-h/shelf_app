class BooksController < ApplicationController
  
  def index
    @user = current_user
    @books = @user.books
    @tags = @user.tags
   
  #debugger
  end
  
  def new
    @user = User.find(params[:user_id])
    sign_in(@user)
    @book = Book.new(title:"")
  end
  
  def create
    @user = current_user
    @book =Book.new(title: params[:book][:title], 
            proper_title: params[:book][:proper_title], price: params[:book][:price], author: params[:book][:author], image: params[:book][:image],memo: params[:book][:memo],
            summary: params[:book][:summary], related_videos: params[:book][:related_videos], favorite: params[:book][:favorite], own: params[:book][:own], 
            user_id: "#{params[:user_id]}")
      if @book.save
        flash[:message] = "追加しました"
        flash[:notice] = "追加しました"
        cookies[:pop]= {:notice=>"追加しました"}
        cookies[:flash] = {:notice=>"追加しました"}
        cookies.signed[:popup] = {:value=>"追加しました"}
        @flash = {:notice=>"追加しました"}
        @@flash = "追加しました"
        flash[:success] = "追加しました"
        session[:notice] = "追加しました"
        redirect_to books_url,  message: "追加しました", notice: "追加しました"
        #debugger

        # flash表示
        # チュートリアル見ながらviewをやる
      end
  end
  
  def show
  end
  
  def edit
  end
  
  def delete
  end
  
end

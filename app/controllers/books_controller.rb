class BooksController < ApplicationController
  
  def index
    @user = current_user
    @books = @user.books
    @tags = @user.tags
    
    flash[:notice] = @user.flash if @user.flash
    @user.update_attributes(flash: nil)
   
  #debugger
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
        @user = User.find(params[:user_id])
        @user.update_attributes(flash: "追加しました")
        
        #flash[:message] = "追加しました"
        #flash[:notice] = "追加しました"
        #cookies.permanent[:pop]= {:notice=>"追加しました"}
        #cookies[:flash] = {:notice=>"追加しました"}
        #cookies[:pop]="追加しました"
        #cookies.signed[:popup] = {:value=>"追加しました"}
        #cookies[:_shelf_app_session] = "追加しました"
        #cookies.signed[:_shelf_app_session] = {:value=>"追加しました"}
        #@flash = {:notice=>"追加しました"}
        #@@flash = "追加しました"
        #flash[:success] = "追加しました"
        #session[:notice] = "追加しました"
        #redirect_to save_url
        
        redirect_to books_url
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
  
  private
    
    def add_flash
      cookies[:flash] = {:notice=>"追加しました"}
      session[:notice] = "追加しました"
      cookies.signed[:popup] = {:value=>"追加しました"}
    end
    
    def add_flash_message
      flash.permit(:notice)
    end
    
  
end

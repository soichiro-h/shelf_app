class BooksController < ApplicationController
  include BooksHelper
  before_action :authenticate_user! , only: [:show, :index, :edit ]
  
  require 'google/apis/youtube_v3'
  
  def index
    
    #debugger
    
    @user = current_user
    @books = @user.books.order(updated_at: "DESC")
    @tags = @user.tags
    
    flash.now[:notice] = @user.flash if @user.flash
    @user.update_attributes(flash: nil)

  end
  
  def new
    
    @user = User.find(params[:user_id])
    sign_in(@user)
    @book = Book.new(title:"")
    @tags = @user.tags
    
    search_youtube
    
  end

 
  def add_tags
    if !params[:tags].nil?
        tag_relations = params[:tags].keys
        
        tag_relations.each{ |rel|
          @book.related_tags.create(tag_id: rel)
        }
    end
  end
  
  def add_videos
    if !params[:videos].nil?
      
      videos = []
      
      #videos_id を抽出
      params[:videos].each { |key, value|
          videos.push(extract_video_id(value)) if !value.empty?
      }
      
      #ceate video
      videos.each { |v| 
        Video.create(video_id: v, book_id: @book.id)
      }
      
    end
  end
  
  
  def create
  
    @book = Book.new(book_params)
    @book.remote_image_url = params[:book][:image]
    
    @book = Book.new(book_params_with_image) if params[:book][:image].class == ActionDispatch::Http::UploadedFile
    
    @book.user_id = params[:user_id]
    
    if @book.save
      
      #タグの関連付け
      
      add_tags
      
      #videos と関連付け
      add_videos
     
      #if !empty?

      @user = User.find(params[:user_id])
      @user.update_attributes(flash: "追加しました")
      
      redirect_to books_url
      
    end
  end
  
  def show
    @user = current_user
    @book = Book.find(params[:id])
    
    flash.now[:notice] = @user.flash if @user.flash
    @user.update_attributes(flash: nil)
    
  end
  
  def edit
    @user = current_user
    @book = Book.find(params[:id])
    @youtube = @book.videos
    @tags = @user.tags
    
    @related_tags_id = @book.tags.ids
    
  end
  
  def update
    
    @user = User.find(params[:user_id])
    @book = Book.find(params[:id])
    
    @update_for_book = Book.new(book_params)
    
  
    if @update_for_book.valid?
      @book.update_attributes!(book_params)
      # uploader にファイルがある時だけ、imageをupdate
      @book.update_attributes( image: params[:book][:image] ) if params[:book][:image].class == ActionDispatch::Http::UploadedFile
    
      @user = User.find(params[:user_id])
      @user.update_attributes(flash: "変更しました")
      
      #update tags
    
      tag_relations = TagRelation.where(book_id: @book.id)
      
      tag_relations.each { |v|
        v.destroy
      }
      
      add_tags
      
      #update videos
      
      videos = @book.videos
      
      videos.each { |v|
        v.destroy
      }
      
      add_videos
   
      redirect_to "/details/#{params[:id]}"
      
    else
      @tags = @user.tags
      @youtube = @book.videos
      @related_tags_id = @book.tags.ids
      
      render 'edit'
    end
    
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    @user = User.find(book.user_id)
    @user.update_attributes(flash: "削除しました")
    redirect_to books_path
  end
  
  private
    
    def book_params
      params.require(:book).permit(:title, :proper_title, :price, :author, #:image,
                :memo, :summary, :params, :favorite, :own, :purchase_url)
    end
    
    def book_params_image
      params.require(:book).permit(:image)
    end
    
    def book_params_with_image
      params.require(:book).permit(:title, :proper_title, :price, :author, :image,
                :memo, :summary, :params, :favorite, :own, :purchase_url)
    end
  
end

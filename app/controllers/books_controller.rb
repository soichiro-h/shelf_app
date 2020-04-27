class BooksController < ApplicationController
  include BooksHelper
  before_action :authenticate_user! , only: [:show, :index, :edit ]
  
  #require 'googleauth'
  require 'google/apis/youtube_v3'
  
  
  def index
    @user = current_user
    @books = @user.books.order(updated_at: "DESC")
    @tags = @user.tags
    
    flash.now[:notice] = @user.flash if @user.flash
    @user.update_attributes(flash: nil)
   
    #debugger
  
  end
  
  
  def sorting_by_order
    
    case params[:sort_by] 
     
      when "created_at"
        if params[:created_at] == "created_at_desc"
          @books = @books.sort_by{ |b| b.created_at}.reverse
          #@books = @books.order(created_at: "DESC")
        else
          @books = @books.sort_by{ |b| b.created_at}
          #@books = @books.order(created_at: "ASC")
        end
        
      when "updated_at"
        if params[:updated_at] == "updated_at_desc"
          @books = @books.sort_by{ |b| b.updated_at}.reverse
          #@books = @books.order(updated_at: "DESC")
        else
          @books = @books.sort_by{ |b| b.updated_at}
          #@books = @books.order(updated_at: "ASC")
        end
        
      when "title"
        if params[:title] == "title_desc"
          @books = @books.sort_by{ |b| b.title }.reverse
          #@books = @books.order(title: "DESC")
        else
          @books = @books.sort_by{ |b| b.title }
          #@books = @books.order(title: "ASC")
        end
     
    end
    
  end
  
  def sort_by
    
    @user = User.find(params[:user_id])
    @tags = @user.tags
    
    sorting_by_tags
    sorting_by_fav_own
    sorting_by_order

    render 'books/index', b: @books
  end
  
  
  def get_service
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = API_KEY
    return youtube
  end
  
  
  def new
    
    @user = User.find(params[:user_id])
    sign_in(@user)
    @book = Book.new(title:"")
    @tags = @user.tags
    
    search_youtube
    
  end
  
  def search_youtube
    
    title = params[:book][:title]
    if !params[:book][:proper_title].blank?
      sub_title = params[:book][:proper_title] 
      keyword = title + " " + sub_title
    else
      if !params[:book][:author].blank?
      author = params[:book][:author] 
      keyword = title + " " + author
      else
        not_search = true
      end
    end
    
    if !not_search
    
      youtube = get_service
      opt = {
        q: keyword,
        type: 'video',
        max_results: 2,
        order: :viewCount, #:rating #:relevance 
      }
      
      # 
      results = youtube.list_searches(:snippet, opt)
      
      @youtube = []
      if !results.nil?
        results.items.each do |item|
          @youtube << item
        end
      end
      
    end
    
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
      #配列にvideos 格納
      videos = []
      #videos_id を抽出
      params[:videos].each { |key, value|
          videos.push(extract_video_id(value)) if !value.empty?
      }
      
      #ceate video
      videos.each { |v| 
        #new_video = Video.create(video_id: v, book_id: @book.id)
        Video.create(video_id: v, book_id: @book.id)
        #@book.related_videos.create(video_id: new_video.id)
      }
      #debugger
      #create video_relation
      
    end
  end
  
  def extract_video_id(url)
    vid = url[/\?v=([^&]+)/]
    #vid.delete("?v=")
    vid.slice!(0..2)
    return vid
  end
  
  
  def create
  
    @book = Book.new(book_params)
    @book.remote_image_url = params[:book][:image]
    
    @book = Book.new(book_params_with_image) if params[:book][:image].class == ActionDispatch::Http::UploadedFile
    
    @book.user_id = params[:user_id]
    
      if @book.save
        
        
        #タグの関連付け
        
        
        #videosのcreate と関連付け
        add_tags
        
        #add_videos
        add_videos
       
        
        #if !empty?
        
        
        
        
        @user = User.find(params[:user_id])
        @user.update_attributes(flash: "追加しました")
        
        redirect_to books_url
        
        # flash表示 実験結果
        
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
      
      #debugger
        

      end
  end
  
  def show
    @user = current_user
    @book = Book.find(params[:id])
    #@tags = @user.tags
    
    flash.now[:notice] = @user.flash if @user.flash
    @user.update_attributes(flash: nil)
    
    #debugger
  end
  
  def edit
    @user = current_user
    @book = Book.find(params[:id])
    @youtube = @book.videos
    @tags = @user.tags
    
    @related_tags_id = @book.tags.ids
    
    #debugger
    
  end
  
  def update
    
    @user = User.find(params[:user_id])
    @book = Book.find(params[:id])
    @tags = @user.tags
    #debugger
  
    if @book.update_attributes!(book_params)
      # uploader にファイルがある時だけ、imageをupdate
      @book.update_attributes( image: params[:book][:image] ) if params[:book][:image].class == ActionDispatch::Http::UploadedFile
        #@book.update_attributes!(book_params)
        #rescue ActiveRecord::RecordInvalid => e
        #puts e.record.errors
        #debugger
      @user = User.find(params[:user_id])
      @user.update_attributes(flash: "変更しました")
      
    else
      @user = User.find(params[:user_id])
      @book = Book.find(params[:id])
      @tags = @user.tags
      #debugger
      render 'edit'
    end
    
    
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





#title: params[:book][:title], 
#proper_title: params[:book][:proper_title], price: params[:book][:price], author: params[:book][:author], image: params[:book][:image],memo: params[:book][:memo],
#summary: params[:book][:summary], related_videos: params[:book][:related_videos], favorite: params[:book][:favorite], own: params[:book][:own], 
#user_id: "#{params[:user_id]}"
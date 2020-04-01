class BooksController < ApplicationController
  
  #require 'googleauth'
  #require 'google/apis/youtube_v3'
  
  API_KEY = 'AIzaSyBWNozwiqcneF6nclfj2vhTF5-oJoC-_6Q'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'
  
  def index
    @user = current_user
    @books = @user.books.order(updated_at: "DESC")
    @tags = @user.tags
    
    flash.now[:notice] = @user.flash if @user.flash
    @user.update_attributes(flash: nil)
   
    #debugger
  
  end
  
  def search
    @user = User.find(params[:user_id])
    @tags = @user.tags
    
    @books = Book.search(params[:search])
    render :index
    
  end
  
  def sorting_by_tags
    
    #選ばれたタグ抽出
    
    unless params[:tags].nil?
    
      @selected_tags = [] 
    
      tags = params[:tags].keys
      tags.each { |t|
        @selected_tags.push(Tag.find(t))
      }
      
      #タグに関連づいた本抽出
      @tagged_books = []
      @selected_tags.each { |t|
      @tagged_books.push(t.books)
      }
      
      @books = @tagged_books.flatten.uniq
      
      
    else
      @books = @user.books
    end
    
    #render :partial => "books/index.html.erb",  collection: @book, as: :b
    #render :index , :collection => @book, as: :b
    #render partial: 'books/index', locals: { b: @books }
    #render :index , locals: { b: @books }
    #debugger
     
  end
  
  def sorting_by_fav_own
      
    if !params[:own_fav].nil?
      books = []
      
      if !params[:own_fav][:by_own].nil?
        own = @books.select do |b|
          b.own
        end
        books.push(own)
      end
      
      if  !params[:own_fav][:by_favorite].nil?
        fav = @books.select do |b|
          b.favorite
        end
        books.push(fav)
      end
      
      @books = books.flatten.uniq
    end
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
  
  
  
  
  
  
  def new
    @user = User.find(params[:user_id])
    sign_in(@user)
    @book = Book.new(title:"")
    @tags = @user.tags
    
    #def get_service
    #  youtube = Google::Apis::YoutubeV3::YouTubeService.new
    #  youtube.key = API_KEY
    #  return youtube
    #end
    
    #youtube = get_service
    #@youtube = youtube.list_searches("id,snippet", type: "video", q: "Factfulness", max_results: 2)
    
    
  end
  
  def extract_video_id(url)
    vid = url[/\?v=([^&]+)/]
    vid.delete("?v=")
  end
  
  def create
    
    
    @book = Book.new(book_params)
    @book.user_id = params[:user_id]
      if @book.save
        
        #タグの関連付け
        if !params[:tags].nil?
        tag_relations = params[:tags].keys
        
        tag_relations.each{ |rel|
          @book.related_tags.create(tag_id: rel)
        }
        end
        
        #videosのcreate と関連付け
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
    #debugger
  end
  
  def edit
    @user = current_user
    @book = Book.find(params[:id])
    @tags = @user.tags
  end
  
  def update
    @book = Book.find(params[:id])
      if @book.update_attributes(book_params)
        @user = User.find(params[:user_id])
        @user.update_attributes(flash: "変更しました")
    
      else
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
      params.require(:book).permit(:title, :proper_title, :price, :author, :image, 
                :memo, :summary, :params, :favorite, :own)
    end
  
end





#title: params[:book][:title], 
#proper_title: params[:book][:proper_title], price: params[:book][:price], author: params[:book][:author], image: params[:book][:image],memo: params[:book][:memo],
#summary: params[:book][:summary], related_videos: params[:book][:related_videos], favorite: params[:book][:favorite], own: params[:book][:own], 
#user_id: "#{params[:user_id]}"
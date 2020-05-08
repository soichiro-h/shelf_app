module BooksHelper
  
  #################################
  #        Shelf メソッド  
  #################################
  
  
  #shelf内　本検索
  
  def search_books #search_books に変えるか？
    @user = User.find(params[:user_id])
    @tags = @user.tags
    
    users_book = Book.where(user_id: @user.id)
    @books = users_book.search(params[:search_books])
    
    render :index
 
  end
  
  
  #ソート
  
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
        else
          @books = @books.sort_by{ |b| b.created_at}
        end
        
      when "updated_at"
        if params[:updated_at] == "updated_at_desc"
          @books = @books.sort_by{ |b| b.updated_at}.reverse
        else
          @books = @books.sort_by{ |b| b.updated_at}
        end
        
      when "title"
        if params[:title] == "title_desc"
          @books = @books.sort_by{ |b| b.title }.reverse
        else
          @books = @books.sort_by{ |b| b.title }
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
  
  
  #################################
  #        Youtube API  
  #################################
  
  API_KEY = ENV['YOUTUBE_API_KEY']
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def get_service
      youtube = Google::Apis::YoutubeV3::YouTubeService.new
      youtube.key = API_KEY
      return youtube
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
        do_not_search = true
      end
    end
  
    if !do_not_search
    
      youtube = get_service
      opt = {
        q: keyword,
        type: 'video',
        max_results: 2,
        order: :viewCount, #:rating #:relevance 
      }
      
      results = youtube.list_searches(:snippet, opt)
      
      @youtube = []
      if !results.nil?
        results.items.each do |item|
          @youtube << item
        end
      end
      
    end
  
  end
  
  def extract_video_id(url)
    vid = url[/\?v=([^&]+)/]
    if !vid.nil?
      vid.slice!(0..2)
      return vid
    end
  end
  
  
  #################################
  #         Rakuten API  
  #################################

  
  def search_rakuten
    @user = current_user
    @tags = @user.tags
    @books = @user.books.order(updated_at: "DESC")
    @guess = []
    sign_in @user
    
    RakutenWebService.configure do |c|
      c.application_id = ENV['RAKUTEN_APP_ID']
      c.affiliate_id = ENV['RAKUTEN_AFFILIATE_ID']
    end
    
    if !params[:new_book_title].empty?
    
      keyword = params[:new_book_title]
  
      over_2char = over_2char?(keyword)
      
      if over_2char
        @items = RakutenWebService::Books::Book.search({
          title: keyword,
          hits: 4,
        })

        if !@items.nil?
          @items.each do |item|
            @guess << item
          end
        
        @book_title = keyword
        end
      else
        @book_title = keyword
      end
    end
    
    render :index
    
  end
 
  
  #keyword が2文字以上かどうか判定
  
  def over_2char?(keyword)
  
    splited_words = []
    
    if keyword.include?("　")
      inspection = keyword.split("　")
   
      inspection.each { |i|
        splited_words << i if !i.blank?
      }
      
      splited_words.each{ |s| 
        return false if s.length == 1
      }
      
    elsif keyword.include?(" ")
      inspection = keyword.split
      
      inspection.each { |i|
        splited_words << i if !i.blank?
      }
      
      splited_words.each{ |s| 
        return false if s.length == 1
      }
    elsif keyword.length == 1
       return false
    else
      return true
    end
    
  end

end

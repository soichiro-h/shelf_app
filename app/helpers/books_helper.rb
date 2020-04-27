module BooksHelper
  
  #################################
  #        Shelf メソッド  
  #################################
  
  
  #shelf内　本検索
  
  def search_books #search_books に変えるか？
    @user = User.find(params[:user_id])
    @tags = @user.tags
    
    users_book = Book.where(user_id: @user.id)
    @books = users_book.search(params[:search])
    
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
    
    #debugger
    
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

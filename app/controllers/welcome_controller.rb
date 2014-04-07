class WelcomeController < ApplicationController
  include WelcomeHelper
  
  def reset
    reset_session
    
    redirect_to action: 'index'
  end
  
  def index
    # # testing good reads connection
#     client = Goodreads::Client.new(:api_key => 'QTFfEaugOxPvTIrzGy0TQ')
#     
#     # testing good reads query
#     author = client.author_by_name('Neal Stephenson')
    
    @message = "Hello, "
    # @author_link = author.link
    # @goodreads = is_returning_twitter_user()
    
    if is_returning_twitter_user()
          
      # @member = get_returning_member()
    end
    
    if is_authorized_user()
      
      twitter_auth = Authorization.find_by_id(session[:twitter])
      goodreads_auth = Authorization.find_by_id(session[:goodreads])
      @member = twitter_auth.member
      
      twitter = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_KEY']
        config.consumer_secret     = ENV['TWITTER_SECRET']
        config.access_token        = twitter_auth.token
        config.access_token_secret = twitter_auth.secret
      end
    
      @twitter = twitter.verify_credentials
      @member.screen_name = @twitter.screen_name
      # @member.profile_image_url = @twitter.profile_image_url
      @member.save
      
      goodreads = Goodreads::Client.new(:api_key => ENV['GOODREADS_KEY'], :api_secret => ENV['GOODREADS_SECRET'])
      
      # @author = goodreads.author_by_name('Neal Stephenson')
      
      # shelf = goodreads.shelf(goodreads_auth.uid, '')
      # total = shelf.total
      # pages = (shelf.total / shelf.books.count).ceil
      # 
      # authors_names = Hash.new
      # (1..pages).each do |page|
      #   shelf = goodreads.shelf(goodreads_auth.uid, '', {:page => page})
      #   
      #   shelf.books.each do |book|
      #     authors_names[book.book.authors.author.name] = book.book.authors.author.name
      #   end
      # end
      
      @authors = []
      
      # Author.transaction do
      #   authors_names.keys.each do |author_name|
      #     twitter_user = twitter.user_search(author_name, {:count => 1}).pop
      #     screen_name = ''
      #     unless twitter_user.nil?
      #       screen_name = twitter_user.screen_name
      #     end
      #     author = {
      #       name: author_name,
      #       screen_name: screen_name
      #     }
      #     @authors << author
      #   
      #     Author.create(name: author_name, screen_name: screen_name, member: @member)
      #   end
      # end
      
      @authors = Author.where(member: @member)
      
    end
    
    #twitter = Twitter::Client.new(
    #  :oauth_token => '117190492-uyi7pm5Gfq24pOwREFTYqgqE0onE9Zesmi7lpqIM',
    #  :oauth_token_secret => 'FnxsYmz6kI5e8LoCnr1Go9TYChSmVgPnHQNCtT4Psepy8'
    #)
    
    #@results = twitter.user_search('Neal Stephenson', :count => 1, :result_type => 'popular')
  end
end

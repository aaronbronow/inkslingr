class WelcomeController < ApplicationController
  def index
    # testing good reads connection
    client = Goodreads::Client.new(:api_key => 'QTFfEaugOxPvTIrzGy0TQ')
    
    # testing good reads query
    author = client.author_by_name('Neal Stephenson')
    
    @message = "Hello, "
    @author_link = author.link
    
    if session.key? :member_secret
      @goodreads = 'good reads ready'
      twitter = Twitter::Client.new(:oauth_token => session[:member_access_token], :oauth_token_secret => session[:member_secret])
      
      begin
        @twitter_user = twitter.verify_credentials
      rescue Exception => e
        logger.debug e
      end
      
      unless @twitter_user.nil?
        @twitter_user_verified = true
      end
    end
    #twitter = Twitter::Client.new(
    #  :oauth_token => '117190492-uyi7pm5Gfq24pOwREFTYqgqE0onE9Zesmi7lpqIM',
    #  :oauth_token_secret => 'FnxsYmz6kI5e8LoCnr1Go9TYChSmVgPnHQNCtT4Psepy8'
    #)
    
    #@results = twitter.user_search('Neal Stephenson', :count => 1, :result_type => 'popular')
  end
end

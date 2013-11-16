class WelcomeController < ApplicationController
  include WelcomeHelper
  
  def index
    # testing good reads connection
    client = Goodreads::Client.new(:api_key => 'QTFfEaugOxPvTIrzGy0TQ')
    
    # testing good reads query
    author = client.author_by_name('Neal Stephenson')
    
    @message = "Hello, "
    @author_link = author.link
    @goodreads = is_returning_twitter_user()
    
    if session.key? :member_secret
      
      ### TODO adwb: move this to auth controller
      twitter = Twitter::Client.new(:oauth_token => session[:member_access_token], :oauth_token_secret => session[:member_secret])
      
      begin
        @twitter_user = twitter.verify_credentials
        
        @member = Member.find_by_twitter_id(@twitter_user.id)
        
        if @member == nil
          logger.debug 'adding new user'
          @member = Member.new(:twitter_id => @twitter_user.id, 
            :screen_name => @twitter_user.screen_name,
            :token => session[:member_access_token],
            :secret => session[:member_secret],
            :profile_image_url => @twitter_user.profile_image_url)
          @member.save
          
          cookies[:twitter_token] = session[:member_access_token]
          cookies[:twitter_secret] = session[:member_secret]
          cookies[:twitter_id] = @twitter_user.id
          
        end
        
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

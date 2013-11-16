require 'oauth'

class AuthController < ApplicationController
  def self.twitter_consumer
    # The readkey and readsecret below are the values you get during registration
    OAuth::Consumer.new('6Usy4SZzhXqma4N3DwybkA', 'MmTuxaXl9c8Q4beCKUWmjZNiVRhFY7zgbkt6RbBbA',
      { :site=>"http://api.twitter.com",
        :scheme => :header 
      })
  end
  
  def sign_in_with_twitter
    @request_token = AuthController.twitter_consumer.get_request_token(:oauth_callback => "http://inkslingr.dev/auth/twitter")
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.secret
    session[:request_token_object] = @request_token
    # Send to twitter.com to authorize
    redirect_to @request_token.authorize_url
    return
  end
    
  def twitter
    logger.debug 'TWITTER AUTH callback'
    
    session[:member_token] = params[:oauth_token]
    session[:member_verifier] = params[:oauth_verifier]
    
    @request_token = session[:request_token_object]
    
    @access_token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    
    session[:member_access_token] = @access_token.token
    session[:member_secret] = @access_token.secret
    
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
    
    redirect_to root_url
  end
end

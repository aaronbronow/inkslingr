require 'oauth'

class AuthController < ApplicationController
  def self.twitter_consumer
    # The readkey and readsecret below are the values you get during registration
    OAuth::Consumer.new('B3MWC2rjPFzNflQISO9QLQ', 
      'xXaXg5UeZjOF1Et2xIY2rTgAPjjvZ4j9ku59al0',
      :site => "https://api.twitter.com"
      )
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
    
    logger.debug @access_token.inspect
    
    # session[:member_access_token] = @access_token.token
    # session[:member_secret] = @access_token.secret
    session[:member_access_token] = '117190492-3xzwgq4ukShk8JrAVht9ZEDRATv9nxeUCu93wBTs'
    session[:member_secret] = 'W71DYmnWHxBYVORkexI3e8jzvH3tdmiIukQN7GH2gGEqo'
    
    twitter = Twitter::REST::Client.new do |config|
      config.consumer_key = 'B3MWC2rjPFzNflQISO9QLQ'
      config.consumer_secret = 'xXaXg5UeZjOF1Et2xIY2rTgAPjjvZ4j9ku59al0'
      config.access_token        = session[:member_access_token]
      config.access_token_secret = session[:member_secret]
    end
    
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
      else
        logger.debug 'returning user authenticating again'
        
        cookies[:twitter_token] = session[:member_access_token]
        cookies[:twitter_secret] = session[:member_secret]
        cookies[:twitter_id] = @twitter_user.id
      end
      
    rescue Exception => e
      logger.debug e
    end
    
    redirect_to root_url
  end
  
  def sign_out
    cookies.delete :twitter_token
    cookies.delete :twitter_secret
    cookies.delete :twitter_id
    session.delete :member_access_token
    session.delete :member_secret
    
    redirect_to root_url
  end
end

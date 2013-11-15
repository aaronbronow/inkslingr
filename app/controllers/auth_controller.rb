class AuthController < ApplicationController
  def twitter
    logger.debug 'TWITTER AUTH callback'
    
    session[:member_token] = params[:oauth_token]
    session[:member_verifier] = params[:oauth_verifier]
    
    @request_token = session[:request_token_object]
    
    @access_token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    
    session[:member_access_token] = @access_token.token
    session[:member_secret] = @access_token.secret
    
    redirect_to root_url
  end
end

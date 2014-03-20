class SessionsController < ApplicationController
  def create
    omni = request.env["omniauth.auth"]
        
    auth = Authorization.find_by_provider_and_uid(omni["provider"], omni["uid"]) || Authorization.new(provider: omni["provider"], uid: omni["uid"], token: omni["credentials"]["token"], secret: omni["credentials"]["secret"])
    session[auth["provider"].to_sym] = auth.id
    auth.save
    
    if auth["provider"] == "goodreads"
      member = Member.new
      member.save
      
      twitter = Authorization.find_by_id(session[:twitter])
      twitter.member = member
      twitter.save
      
      goodreads = Authorization.find_by_id(session[:goodreads])
      goodreads.member = member
      goodreads.save    
    end
    
    redirect_to root_url
  end
 

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
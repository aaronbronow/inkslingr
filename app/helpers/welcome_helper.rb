module WelcomeHelper
  def is_returning_twitter_user
    # true if cookies.key? :twitter_secret and cookies.key? :twitter_token and cookies.key? :twitter_id
    session.key? :twitter
  end
  
  def is_authorized_user
    session.key? :twitter and session.key? :goodreads
  end
  
  def get_returning_member
    # @twitter_user = twitter.verify_credentials
    
    Member.find_by_twitter_id(cookies[:twitter_id])
  end

end

module WelcomeHelper
  def is_returning_twitter_user
    true if cookies.key? :twitter_secret and cookies.key? :twitter_token and cookies.key? :twitter_id
  end
  
  def get_returning_member
    Member.find_by_twitter_id(cookies[:twitter_id])
  end
end

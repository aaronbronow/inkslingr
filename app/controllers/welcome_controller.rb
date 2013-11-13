class WelcomeController < ApplicationController
  def index
    # testing good reads connection
    client = Goodreads::Client.new(:api_key => 'QTFfEaugOxPvTIrzGy0TQ')
    
    # testing good reads query
    author = client.author_by_name('Neal Stephenson')
    
    @message = "Hello, "
    @author_link = author.link
    
    twitter = Twitter::Client.new(
      :oauth_token => '117190492-uyi7pm5Gfq24pOwREFTYqgqE0onE9Zesmi7lpqIM',
      :oauth_token_secret => 'FnxsYmz6kI5e8LoCnr1Go9TYChSmVgPnHQNCtT4Psepy8'
    )
    
    @results = twitter.user_search('Neal Stephenson', :count => 1, :result_type => 'popular')
  end
end

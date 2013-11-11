class WelcomeController < ApplicationController
  def index
    # testing good reads connection
    client = Goodreads::Client.new(:api_key => 'QTFfEaugOxPvTIrzGy0TQ', :api_secret => 'doVGGGX7lzIv0XDXZKfGGw1bYzDIkPoefQptZsfJqQ')
    
    # testing good reads query
    author = client.author_by_name('Neal Stephenson')
    
    @message = "Hello, "
    @author_link = author.link
  end
end

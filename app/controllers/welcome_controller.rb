class WelcomeController < ApplicationController
  def index
    # testing good reads connection
    client = Goodreads::Client.new(:api_key => 'QTFfEaugOxPvTIrzGy0TQ')
    
    # testing good reads query
    author = client.author_by_name('Neal Stephenson')
    
    @message = "Hello, "
    @author_link = author.link
    
    twitter = Twitter::Client.new(
      :oauth_token => '117190492-4jJksgZp5BggKrVMxJ8I8pyCQJPACJeXwBkbjlRJ',
      :oauth_token_secret => '1vE0zf4Gx6PZpc1Fbv9MRq2eV5TnskujhmHHjDAMH5Eiy'
    )
    
    @results = twitter.user_search('Neal Stephenson', :count => 1, :result_type => 'popular')
  end
end

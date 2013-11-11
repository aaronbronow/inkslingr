class WelcomeController < ApplicationController
  def index
    # testing good reads connection
    client = Goodreads::Client.new(:api_key => 'QTFfEaugOxPvTIrzGy0TQ', :api_secret => 'doVGGGX7lzIv0XDXZKfGGw1bYzDIkPoefQptZsfJqQ')
    
    # testing good reads query
    author = client.author_by_name('Neal Stephenson')
    
    @message = "Hello, "
    @author_link = author.link
    
    Twitter.configure do |config|
      config.consumer_key = '6Usy4SZzhXqma4N3DwybkA'
      config.consumer_secret = 'MmTuxaXl9c8Q4beCKUWmjZNiVRhFY7zgbkt6RbBbA'
      config.oauth_token = '117190492-4jJksgZp5BggKrVMxJ8I8pyCQJPACJeXwBkbjlRJ'
      config.oauth_token_secret = '1vE0zf4Gx6PZpc1Fbv9MRq2eV5TnskujhmHHjDAMH5Eiy'
    end
    
    @results = Twitter.user_search('Neal Stephenson', :count => 1, :result_type => 'popular')
  end
end

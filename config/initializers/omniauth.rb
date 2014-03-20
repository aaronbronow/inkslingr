Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :goodreads, ENV['GOODREADS_KEY'], ENV['GOODREADS_SECRET']
end

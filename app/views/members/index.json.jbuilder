json.array!(@members) do |member|
  json.extract! member, :twitter_id, :screen_name, :token, :secret, :profile_image_url
  json.url member_url(member, format: :json)
end

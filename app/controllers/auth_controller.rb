class AuthController < ApplicationController
  def twitter
    logger.debug 'TWITTER AUTH callback'
    redirect_to root_url
  end
end

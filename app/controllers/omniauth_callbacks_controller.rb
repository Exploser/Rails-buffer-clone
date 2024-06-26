class OmniauthCallbacksController < ApplicationController
  def twitter2
    twitter_account = Current.user.twitter_account.where(username: auth.info.nickname).first_or_initialize
    twitter_account.update(
      name: auth.info.name,
      username: auth.info.nickname ,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.refresh_token,
      )
       # Log the contents of the auth object REMOVE LATER
      Rails.logger.debug("Auth object: #{auth.inspect}")
      redirect_to twitter_account_index_path, notice: "Successfully Connected Twitter Account"
  end

  def auth
    request.env['omniauth.auth']
  end
end

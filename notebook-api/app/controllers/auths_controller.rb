class AuthsController < ApplicationController
  def create
    hmac_secret = ENV['TOKEN']
    payload = { name: params[:name], exp: Time.now.to_i + (60 * 60 * 24) }
    token = JWT.encode payload, hmac_secret, 'HS256'
    render json: { token: token}
  end
end

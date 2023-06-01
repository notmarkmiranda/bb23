require './lib/json_web_token'

class SessionsController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      expiration = user.token_expiration.to_i

      render json: { token: token, expiration: expiration, email: user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end

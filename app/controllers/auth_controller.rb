class AuthController < ApplicationController
  def sign_in
    render plain: "Sign in page works!"
  end

  def youtube_callback
    auth = request.env['omniauth.auth']
    if auth.present?
      @access_token = auth['credentials']['token']
      @refresh_token = auth['credentials']['refresh_token']
      @success = true
      @info = auth['info']
    else
      @error = params[:error] || 'No authentication data received'
      @success = false
    end
    render 'youtube_callback'
  end
end

class ReauthController < ApplicationController

  def reauth
    render json: {session_id: Rails.application.message_verifier(:session_auth).verify(params[:token])}
  end

end

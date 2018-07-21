class Users::OmniauthController < ApplicationController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:success] = 'Iscrizione con facebook avvenuta!'
      sign_in_and_redirect @user
    else
      flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end 
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
    redirect_to new_user_registration_url
  end

end

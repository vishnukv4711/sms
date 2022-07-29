class ApplicationController < ActionController::Base

  def check_user_sign_in
    unless user_signed_in?
      flash.alert = "please sign in"
      redirect_to new_user_session_path
    end
  end

  def admin_check
    # c
    #
  end

end

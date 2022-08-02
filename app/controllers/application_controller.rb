class ApplicationController < ActionController::Base

  def check_user_sign_in
    unless user_signed_in?
      flash.alert = "please sign in"
      redirect_to new_user_session_path
    end
  end

  def admin_check
    unless current_user.is_admin?
      flash.alert = "only admin can perform such tasks"
      # debugger
      redirect_to users_path
    end
  end

  def intended_user
    unless current_user.id == params[:id].to_i || current_user.is_admin?
      flash.alert = "only #{User.find(params[:id]).name} can do that operation"
      redirect_to users_path
    end
  end



end

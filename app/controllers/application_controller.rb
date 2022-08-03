class ApplicationController < ActionController::Base

  def check_user_sign_in
    debugger
    unless user_signed_in?
      flash.alert = "please sign in"
      redirect_to new_user_session_path
    end
  end

  def admin_check
    debugger
    unless current_user.is_admin?
      flash.alert = "only admin can perform such tasks"
      # debugger
      redirect_to users_path
    end
  end

  def intended_user
    debugger
    unless current_user.id == params[:id].to_i || current_user.is_admin?
      flash.alert = "only #{User.find(params[:id]).name} can do that operation"
      redirect_to users_path
    end
  end


  def academic_crud
    debugger
    unless Student.find(session[:student_id]).users.include? current_user || current_user.is_admin?
      flash.alert = "write operation is restricted to respective teachers and admin"
      redirect_to current_user
    end
  end

  # def check_student_sign_in
  #   debugger
  #   unless student_signed_in?
  #     redirect_to new_student_session_path
  #   end
  # end

end

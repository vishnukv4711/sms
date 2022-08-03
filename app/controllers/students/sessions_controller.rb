# frozen_string_literal: true

class Students::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # super
    if student_signed_in?
      flash.notice = "welcome #{current_student.first_name}"
      redirect_to student_path(current_student.id)
    else
      flash.alert = "invalid email or password"
      redirect_to new_student_session_path
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]


  # GET /resource/sign_in
  # def new
  #   debugger
  # end

  # POST /resource/sign_in
  def create
    # super                #some error happened with this on, render is happening inside devise and render and redirect can't be used for same action
    if user_signed_in?
      if current_user.is_admin?
        redirect_to schools_path
      else
        # debugger
        redirect_to user_path(current_user.id)
      end
    else
      flash.alert = "The username or password you enter is wrong!!!!!!!"
      redirect_to new_user_session_path
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end

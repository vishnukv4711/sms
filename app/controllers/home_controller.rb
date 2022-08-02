class HomeController < ApplicationController

  def index
    if user_signed_in?
      if current_user.is_admin?
        redirect_to schools_path
      else
        redirect_to users_path
      end
    end
  end
end
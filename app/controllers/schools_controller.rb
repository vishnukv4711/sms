class SchoolsController < ApplicationController

  before_action :check_user_sign_in

  def index
    @standards = Standard.all
  end

  def search
    debugger
  end

end
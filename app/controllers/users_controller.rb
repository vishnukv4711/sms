class UsersController < ApplicationController

  before_action :set_user, only: [:show]


  def index
    # debugger
    # @users = User.where(is_admin?:  false)
    @users = User.all
  end

  def show
    # debugger

  end

  def new
    @user = User.new
  end

  def create
    # debugger
    @user = User.new(user_params)
    @user.password = (0..5).map{("a".."z").to_a[rand(26)]}.join+(0...4).map{rand(10).to_s}.join
    if @user.save
      flash.notice = "created account for #{@user.name}"
      redirect_to @user
    else
      flash.alert = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, standard_ids:[])
  end

  def set_user
    @user = User.find(params[:id])
  end

end
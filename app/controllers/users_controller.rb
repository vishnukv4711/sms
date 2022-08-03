class UsersController < ApplicationController

  before_action :check_user_sign_in
  before_action :intended_user, only: [:edit, :update]
  before_action :admin_check, only: [:new, :create, :destroy]
  before_action :set_user, except: [:index, :new, :create]
  before_action :nullify_student_session


  def index
    @users = User.all if current_user.is_admin?
    @users = User.where(is_admin?:  false) unless current_user.is_admin?
  end

  def show
  end

  def edit
    # debugger
  end

  def update
    debugger
    if @user.update(user_params)
      params[:user][:standard_ids].each do |s|
        @user.students << Standard.find(s).students unless s.length == 0
      end
      flash.notice = "#{@user.name}'s details updated successfully"
      redirect_to @user
    else
      flash.alert = @user.errors.full_messages
      redirect_to edit_user_path(@user)
    end
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # @user.password = (0..5).map{("a".." z").to_a[rand(26)]}.join+(0...4).map{rand(10).to_s}.join
    @user.password = "password"
    # debugger
    if @user.save
      params[:user][:standard_ids].each do |s|
        @user.students << Standard.find(s).students unless s.length == 0
      end
      flash.notice = "created account for #{@user.name}"
      redirect_to @user
    else
      flash.alert = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def destroy
    flash.alert = "#{@user.name} deleted successfully"
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, standard_ids:[])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def nullify_student_session
    session[:student_id] = nil
  end

end
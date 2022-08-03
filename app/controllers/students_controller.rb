class StudentsController < ApplicationController
  # before_action :check_student_sign_in, only: [:show]
  before_action :check_user_sign_in
  before_action :valid_standard_check, only: [:create, :update]
  before_action :teacher_check, except: [:index, :show]
  before_action :set_user, only: [:show, :destroy, :edit, :update]
  # before_action :student_params, only: [:create]



  def index
    # debugger
    session[:student_id] = nil
    # if params[:standard] && Standard.find(params[:standard]).students.length != 0
    if params[:standard]
      @students = Student.where(standard_id: params[:standard].to_i)
    else
      @students = Student.all
    end
  end

  def new
    # debugger
    @student = Student.new
    if params[:standard]
      # debugger
      @student.standard_id = params[:standard].to_i
    end
  end

  def create
    debugger
    @student = Student.new(student_params)
    # if @student.first_name != ""  &&  @student.last_name != "" && @student.date_of_birth != nil                #@student.date_of_birth.year.to_s shows Nilclass error otherwise
    #   password = @student.first_name[0,2].upcase + @student.last_name[0,2].upcase + @student.date_of_birth.year.to_s
    #   @student.password = password
    # end
    @student.password = "password"
    if @student.save
      # User.where(is_admin?: true)[0].students << @student  #all students are associated with principal so that it will pass the teacher_check
      # Standard.find(params[:student][:standard_id]).students << @student
      # debugger
      Standard.find(params[:student][:standard_id]).users.each do |user|
        user.students << @student
      end
      flash.notice = "student created"
      redirect_to @student
      # if current_user.is_admin?
      #   redirect_to students_path(@student)
      # else
      #   redirect_to current_user
      # end
    else
      flash.alert = @student.errors.full_messages
      redirect_to new_student_path
    end
  end

  def show
    debugger
    session[:student_id] = @student.id
  end

  def edit
    # debugger
  end


  def update
    debugger
    if @student.update(student_params)
      @student.user_ids = []
      Standard.find(params[:student][:standard_id]).users.each do |user|
        user.students << @student
      end
      flash.notice = "#{@student.first_name}'s details updated successfully"
      redirect_to @student
    else
      flash.alert = @student.errors.full_messages
      redirect_to edit_student_path(@student)
    end
  end

  def destroy
    flash.alert = "#{@student.first_name} deleted successfully"
    @student.destroy
    redirect_to students_path
  end


  private

  def set_user
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :address, :email, :contact_number, :mother_name, :father_name, :date_of_birth, :standard_id, :blood_group)
  end

  def teacher_check
    debugger
    if params[:id]  #params[:id] will be nil for new and create
      unless current_user.students.include? Student.find(params[:id])
        flash.alert = "such changes can be made only by admins or respective teacher"
        redirect_to users_path
      end
    end

    # debugger
    if params[:action] == "new" && params[:standard]
      unless current_user.standard_ids.include? params[:standard].to_i
        flash.alert = "you can't add students into #{Standard.find(params[:standard]).standard.camelize}"
        redirect_to current_user
      end
    elsif params[:action] == "create"
      unless current_user.standard_ids.include? params[:student][:standard_id].to_i
        flash.alert = "you can't add students into #{Standard.find(params[:student][:standard_id].to_i).standard.camelize}"
        redirect_to current_user
      end
    end
  end


  def valid_standard_check
    debugger
    if params[:student][:standard_id].to_i == 0
      flash.alert = "please select a valid standard"
      redirect_to request.referer
    elsif params[:student][:blood_group] == "select blood group"
      flash.alert = "please select a valid blood group"
      redirect_to request.referer
    end
  end



end
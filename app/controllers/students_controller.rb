class StudentsController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :edit, :update]
  # before_action :student_params, only: [:create]
  before_action :check_user_sign_in



  def index
    debugger
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
    # debugger
    @student = Student.new(student_params)
    if @student.first_name != ""  &&  @student.last_name != "" && @student.date_of_birth != nil                #@student.date_of_birth.year.to_s shows Nilclass error otherwise
      password = @student.first_name[0,2].upcase + @student.last_name[0,2].upcase + @student.date_of_birth.year.to_s
      @student.password = password
    end
    if @student.save
      flash.notice = "student created"
      redirect_to students_path(@student)
    else
      flash.alert = @student.errors.full_messages
      redirect_to new_student_path
    end
  end

  def show
    session[:student_id] = @student.id
    # debugger
  end

  def edit
  end


  def update
    if @student.update(student_params)
      flash.notice = "#{@student.first_name}'s details updated successfully"
      redirect_to @student
    else
      flash.alert = ["Something prevented the student from getting updated", "please make sure you fill all the required details"]
      redirect_to students_path
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



end
class StudentsController < ApplicationController
  before_action :set_user, only: [:show]
  # before_action :student_params, only: [:create]


  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    debugger
    password = @student.first_name[0,2].upcase + @student.last_name[0,2].upcase + @student.date_of_birth.year.to_s
    @student.password = password
    if @student.save
      flash.notice = "student created"
      redirect_to students_path(@student)
    else
      flash.alert = "error"
      redirect_to new_student_path
    end
  end

  def show
  end

  def edit
  end


  private

  def set_user
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :address, :email, :contact_number, :mother_name, :father_name, :date_of_birth)
  end

end
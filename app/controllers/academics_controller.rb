class AcademicsController < ApplicationController


  def new
    # debugger
    # @student = fetch_student
    unless session[:student_id] == nil
      @academic = Academic.new
    else
      flash.alert = "select a student"
      redirect_to students_path
    end

  end

  def create
    debugger
    @academic = Academic.new(academic_params)
    @academic.student_id = session[:student_id]
    if @academic.save
      flash.notice = "academics created for #{Student.find(session[:student_id]).first_name}"
      redirect_to students_path
    else
      flash.alert = "something went wrong"
      redirect_to students_path
    end
  end

  private

  def set_academic

  end

  def academic_params
    params.require(:academic).permit(:english, :maths, :science, :social, :computer)
  end

  def set_student
    Student.find(params[:id])
  end

  # def fetch_student
  #   Student.find(Rails.application.routes.recognize_path(URI(request.referer).path)[:id].to_i)
  # end

end
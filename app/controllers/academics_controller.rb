class AcademicsController < ApplicationController
  before_action :check_user_sign_in
  before_action :set_student


  def new
    # debugger
    # @student = fetch_student
    if session[:student_id] != nil
      @academic = Academic.new
      if @student.academics.count !=0
        @student.academics.each do |a|
          if a.exam_type == params[:exam_type].capitalize
            flash.alert = "#{params[:exam_type].capitalize} already exists.\n You can edit this"
            # debugger
            @academic = Academic.find(a.id)
            # redirect_to edit_academic_path(params[:exam_type])
            # redirect_to edit_academic_path(a)
            redirect_to '/academics/'+@student.id.to_s+'/edit?exam_type='+params[:exam_type]
          end
        end
      end
      # if @student.academics.count >= 3
      #   flash.alert = "academics already added for the student please go with update"
      #   redirect_to @student
      # end
    else
      flash.alert = "select a student"
      redirect_to students_path
    end

  end

  def create
    # debugger
    @academic = Academic.new(academic_params)
    @academic.student_id = session[:student_id]
    # debugger
    # if @student.academics.count != 0
    #   @student.academics.each do |a|
    #     if a.exam_type == params[:exam_type]
    #       flash.alert = "#{params[:exam_type]} already exists"
    #       redirect_to edit_academic_path(params[:exam_type])
    #     end
    #   end
    # end
    # debugger
    if @academic.save
      flash.notice = "academics created for #{Student.find(session[:student_id]).first_name}"
      redirect_to students_path
    else
      flash.alert = "something went wrong"
      redirect_to students_path
    end
  end



  def edit
    # debugger
    if params[:exam_type] == 'quarterly'
      @academic = Academic.find(@student.academics[0].id)
    elsif params[:exam_type] == 'half-yearly'
      @academic = Academic.find(@student.academics[1].id)
    elsif params[:exam_type] == 'annual'
      @academic = Academic.find(@student.academics[2].id)
    end
  end

  def update
    # debugger
    @academic = Academic.find(params[:id])
    if @academic.update(academic_params)
      flash.notice = "#{@student.first_name}'s #{params[:exam_type]} updated successfully"
      redirect_to @student
    else
      flash.alert = "something went wrong"
      redirect_to students_path
    end
  end

  private

  def set_academic

  end

  def academic_params
    params.require(:academic).permit(:english, :maths, :science, :social, :computer, :exam_type.downcase)
  end

  def set_student
    @student = Student.find(session[:student_id])
  end

  # def fetch_student
  #   Student.find(Rails.application.routes.recognize_path(URI(request.referer).path)[:id].to_i)
  # end

end
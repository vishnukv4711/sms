class StudentsController < ApplicationController
  before_action :set_user, only: [:show]


  def index
    @students = Student.all
  end

  def new

  end

  def show
  end

  def edit

  end


  private

  def set_user
    @student = Student.find(params[:id])
  end

end
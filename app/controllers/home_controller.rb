class HomeController < ApplicationController
  def index
    @standards = Standard.all
  end
end
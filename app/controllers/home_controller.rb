class HomeController < ApplicationController
  def index
  end

  def test_delete
    flash[:notice] = "Delete test successful!"
    redirect_to root_path
  end
  
end

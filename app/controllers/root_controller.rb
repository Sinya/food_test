class RootController < ApplicationController
  
  def home
  	redirect_to posts_path if signed_in?
  end

  def snadbox
  	# session[:our_data] = 1234
  end

end

class UsersController < ApplicationController
 
 	def show
	  	if !current_user
	      redirect_to root_path
	    end

	    @graph = Koala::Facebook::API.new(current_user.oauth_token)
	    @profile = @graph.get_object("me")
		@friends = @graph.get_connections("me", "friends")

  	end
end

class Food < ActiveRecord::Base

	def self.from_food_list(user)
  		where("user_id = :user_id", user_id: user.id)
  	end 

end

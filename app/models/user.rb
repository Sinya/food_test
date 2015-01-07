class User < ActiveRecord::Base

	  has_many :out_followings, class_name: "Following", foreign_key: :from_id, dependent: :destroy
	  has_many :followed_users, class_name: "User", through: :out_followings, source: :to
	  has_many :in_followings, class_name: "Following", foreign_key: :to_id, dependent: :destroy
	  has_many :followers, class_name: "User", through: :in_followings, source: :from
	  
	  has_many :posts
	  has_many :foods

	  before_save { self.email = email.downcase }
	  before_save { self.session_token ||= Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s) }

	has_secure_password
	validates :name, presence: true, length: { maximum: 30 } # length set
	validates :email, format: { with: /\A[^@]+@[^@]+\z/ }, uniqueness: true

	# Create a following from self to the user
	def follow(user)
		out_followings.create(to_id: user.id)
	end

	# Unfollow the user by destroying the following from self to user
	def unfollow(user)
		following = out_followings.find_by(to_id: user.id)
		if following
			following.destroy
			true
		else
			false
		end
	end

	# Is following user?
	def following?(user)
		followed_users.exists?(user.id)
	end

	# Is followed by user?
	def followed_by?(user)
		followers.exists?(user.id)
	end 

end

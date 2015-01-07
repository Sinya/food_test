module SessionsHelper
	def sign_in(user)
		session[:session_token] = user.session_token
	end

	def signed_in? #用戶登入了嗎
		!current_user.nil?
	end

	def current_user #現在登入的用戶
		@current_user ||= User.find_by_session_token(session[:session_token])
	end

	def current_user?(user)
		current_user == user
	end

	def authenticate_user
		unless signed_in?
		flash[:notice] = "Sign-in to continue"
			redirect_to new_session_path
		end
	end

	def sign_out
		@current_user = nil
		session.delete(:session_token)
	end
end

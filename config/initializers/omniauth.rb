OmniAuth.config.logger = Rails.logger

 Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, '510499705759383', '923b68fd76e87d6f3a39f19734582056', 
	 :scope => 'email, user_birthday, read_stream, user_friends', :display => 'popup'
 end
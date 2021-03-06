module SessionsHelper
	#Login the given user
	def log_in(user)
		session[:user_id] = user.id
	end

	#remember a user in a persistent session
	def remember(user)
		user.remember
		cookie.permanent.signed[:user_id] = user.id
		cookie.permanent[:remember_token] = user.remember_token
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:sremember_token)
	end

	#return the current logged in user (if any)
	def current_user
		if(user_id = session[:user_id])
			@current_user ||= User.find_by(id: session[:user_id])
		elsif(user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookie[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end 

	#return true if the user is logged in, false otherwise
	def logged_in?
		!current_user.nil?
	end

	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil	
	end
end

class AdminsController < ApplicationController
	def new
		
	end

	def create
		admin = Admin.new(admin_params)
		if admin.save
			session[:user_id]
			redirect_to '/'
		else
			redirect_to '/signup'
		end
	end

	private
	def admin_params
		params.require(:admin).permit(:name, :email, :password, :password_confirmation)
	end
end

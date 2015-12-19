class UsersController < Clearance::UsersController
	before_filter :redirect_signed_in_users, only: [:create, :new]
  skip_before_filter :require_login, only: [:create, :new]
  skip_before_filter :authorize, only: [:create, :new] 

	def create
    @user = user_from_params
    if @user.save
      sign_in @user
      flash[:success] = "Congratulations! You have successfully sign up!"
      redirect_back_or root_path
    else
    	array = []
    	
    	@user.errors.messages.each do |message|
    		array << message
    	end
      flash[:danger] = array.join(" ")
      redirect_back_or root_path
    end
  end

	private

	def redirect_signed_in_users
		@user = User.find_by(email:params[:user][:email])
		byebug
    if @user
    	flash[:danger] = "The account is exist! Please login!"
      redirect_to Clearance.configuration.redirect_url
    end
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    name = user_params.delete(:name)
    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.name = name
    end
  end
end

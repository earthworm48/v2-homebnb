class SessionsController < Clearance::SessionsController

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]

    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      @user = authentication.user 
      authentication.update_token(auth_hash)

      session[:user_id] = @user.id    
      flash[:success] = "Welcome, #{@user.name}!"

      redirect_to root_path

    else
      user = User.create_with_auth_and_hash(authentication,auth_hash)
      flash[:success] = "Congratulations!You have signed up!"  
      redirect_to root_path
    end

  end

  def create
    @user = authenticate(params)
      
      if @user
        session[:user_id] = @user.id
        flash[:success] = "Welcome back! #{@user.name}"  
        redirect_back_or root_path
      else
        flash[:danger] = "Wrong email & password combination"
        redirect_back_or root_path
      end

  end

  def show

  end

  def destroy
    session[:user_id] = nil
    flash[:danger] = "Signed out successfully!"
    redirect_back_or root_path
  end
end
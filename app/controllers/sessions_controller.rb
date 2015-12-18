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
    byebug
    sign_in(@user) do |status|
      byebug
      if status.success?
        flash[:success] = "Congratulations!You have signed up!"  
        redirect_back_or url_after_create
      else
        byebug
        flash.now.warning = status.failure_message
        render template: "sessions/new", status: :unauthorized
      end
    end
  end

  def show
    byebug
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :success => "Signed out!"
  end
end
module Controllers
  module Authentication


    def authenticate_api_user!
      if request.headers['HTTP_USER_KEY'].present?
        authenticate_with_3scale!
      elsif params[:access_token]
        authenticate_with_token!
      else
        not_authorized!
      end
    end

    def authenticate_with_token!
      unless load_user(params[:access_token])
        not_authorized!
      else
        true
      end
    end

    def authenticate_with_3scale!
      client = ThreeScale::Client.new(provider_key: Settings.threescale.provider_key)
      response = client.authorize(user_key: request.headers['HTTP_USER_KEY'], usage: { hits: 1 })
      if response.success? && load_user(request.headers['HTTP_USER_KEY'])
        true
      else
        not_authorized!
      end
    end

    def load_user(token)
      @user = User.find_by(access_token: token)
    end

    def not_authorized!
      render json: {error: 'Not Authorized'}, status: 401
      false
    end

  end
end
class UserController < ApplicationController
  def login
    service = UserService.new
    username = params[:username]
    password = params[:password]
    @user = service.login(username, password)
    if @user == nil
      @response = BaseDto.new(status: 'error', message: 'No users found', data: nil)
      return render json: @response.as_json, status: :not_found
    end
  # Mengubah data user menjadi UserDTO

    session[:user_id] = @user.id
    @userDto = UserDto.new(@user)
    @response = BaseDto.new(status: 'success', message: 'Login successfully', data: @userDto)
    return render json: @response.as_json, status: :ok
  end

  def logout
    session.delete(:user_id)
    @response = BaseDto.new(status: 'success', message: 'Logged out successfully', data: nil)
    render json: @response.as_json, status: :ok
  end
end

module Api
  module V1
    class SessionsController < BaseController

      def create
        @success, @user, @heading, @alert = User.authenticate(params[:email], params[:password])
          # @user.device_token = params[:device_token]
          # @user.device_id = params[:device_id]
          # @user.save
          @data = @user if @user && @success
          session[:user_id] = @user.id
          render json: @data
        end

        def destroy
          if session[:user_id]
            @user = User.find(params[:id])
            session[:user_id] = nil
            @alert = "Logging out successfully"
            render json: @data
          else
           @alert = "You have not logged in, please login"
         end

       end

     end
   end
 end

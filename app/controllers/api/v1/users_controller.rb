module Api
  module V1
    class UsersController < BaseController

      def create
          @user = User.new(user_params)
          @user.email = user_params[:email]
          if @user.valid?
            @user.save
            session[:user_id] = @user.id
            @alert = "Account has been created successfully"
            @data = @user
            render json: {:user => @data }, status: 200
          else
            @success = false
            @alert = "Unable to create an account"
            @errors = @user.errors
          end
        # end
      end

      def forgot_password
        @proc_code = Proc.new do
          @user = User.find_by_email(params[:email])

          if @user.present?
            @user.generate_password_token
            @user.save
            UserMailer.forgot_password(@user).deliver
            @success = true
            @alert = "The reset password instructions has been sent to your Email ID";
          else
           @success = false
           @alert = "Unable to send your request"
         end
       end
     end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :auth_token, :reset_password_token)
    end

  end
end
end

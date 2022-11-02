class Api::V1::AuthenticationController < ApplicationController

    def registration
        @user = User.new(user_params)

        if @user.save
            render json: {message: "User successfuly created", status: :created}
        else
            render jsonapi_errors: @user.errors
        end
    end

    private

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end
end

class Api::V1::AuthenticationController < ApplicationController

    def registration
        @user = User.new(user_params)

        if @user.save
            render json: {status: "Success", message: "User successfuly created"}, status: :created
        else
            render json: {status: "Error", errors: @user.errors}, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end
end

class Api::V1::AuthenticationController < ApplicationController

    def registration
        @user = User.new(user_params)

        if @user.save
            render json: {status: "Success", message: "User successfuly created"}, status: :created
        else
            render json: {status: "Error", errors: @user.errors}, status: :unprocessable_entity
        end
    end

    def sign_in
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
            time = Time.now + 1.hours.to_i
            token = JsonWebToken.encode(user_id: @user.id, exp: time)
            render json: {token: token, exp: time.to_i, uid: @user.id}, status: :ok
        else
            render json: {error: 'unauthorized'}, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end
end

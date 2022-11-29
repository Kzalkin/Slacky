class ApplicationController < ActionController::API

    def authorize_request
        header = request.headers['Authorization']
        uid = request.headers['uid']
        exp = request.headers['exp']
        header = header.split(' ').last if header

        begin
            @decoded = JsonWebToken.decode(header)
            @current_user = User.find(@decoded[:user_id])

            render json: {errors: 'uid error' }, status: :unauthorized unless uid && uid.to_i == @decoded[:user_id].to_i
            render json: {errors: 'exp error' }, status: :unauthorized unless exp && exp.to_i == @decoded[:exp].to_i

        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
            
        rescue JWT::DecodeError => e
            render json: {errors: e.message }, status: :unauthorized
        end
    end

    def current_user
        if request.headers['uid']
            @current_user = User.find(request.headers['uid'])
        end
    end
end

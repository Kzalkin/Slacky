class Api::V1::UsersController < ApplicationController
    before_action :authorize_request

    def index
        @users = User.all
        render jsonapi: @users
    end

    def show
        @user = User.find(params[:id])

        render jsonapi: @user
    end

end

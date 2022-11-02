class Api::V1::UsersController < ApplicationController
    before_action :authorize_request

    def index
        @users = User.all
        render jsonapi: @users
    end

end

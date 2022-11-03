class Api::V1::ChannelsController < ApplicationController
    def index
        uid = request.headers['uid']
        @user = User.find(uid)

        render jsonapi: @user.channels, include: [:users]
    end
end

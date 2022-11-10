class Api::V1::DirectMessagesController < ApplicationController


    def index
        @user = User.find(params[:user_id])
        @direct_messages = @user.received_direct_messages

        render jsonapi: @direct_messages, include: [:sender]
    end
end

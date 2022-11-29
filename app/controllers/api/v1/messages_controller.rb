class Api::V1::MessagesController < ApplicationController
    def create
        @channel = params[:receiver_class].constantize.find(params[:receiver_id])
        @user = @channel.members.find(request.headers['uid'])

        @message = @user.messages.create!(body: message_params[:body], channel_id: @channel.id)

        render jsonapi: @message, include: [:user, :channel]
    end

    private

    def message_params
        params.permit(:body)
    end
end

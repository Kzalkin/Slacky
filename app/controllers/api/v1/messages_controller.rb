class Api::V1::MessagesController < ApplicationController
    before_action -> {check_params("receiver_class", "receiver_id")}, only: :create

    def create
        @channel = params[:receiver_class].constantize.find(params[:receiver_id])
        @user = @channel.members.find(request.headers['uid'])

        @message = @user.messages.new(body: message_params[:body], channel_id: @channel.id)

        if @message.save
            render jsonapi: @message, include: [:user, :channel]
        else
            render jsonapi_errors: @message.errors
        end
    end

    private

    def message_params
        params.permit(:body)
    end

    def check_params(*inputs)
        errors = []
        inputs.each {|param| errors.push(param) unless params.has_key?(param.to_sym)}

        render json: {status: "Error", error: "No #{errors.join(", ")} found"} if errors.length > 0
    end
end

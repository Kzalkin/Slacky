class Api::V1::MessagesController < ApplicationController
    before_action -> {check_params("receiver_class", "receiver_id")}, only: :create
    before_action :set_channel, only: :create

    def create
        @message = current_user.messages.new(body: message_params[:body], channel_id: @channel.id)

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

    def create_name(user1, user2)
        users = [user1, user2].sort
        "private_#{users.first.id}_#{users.last.id}"
    end

    def set_channel
        if params[:receiver_class] == "User"
            @user = User.find(params[:receiver_id])
            @name = create_name(current_user, @user)
            @channel = Channel.find_by(name: @name) || Channel.create_private_room([@user, current_user], @name)
        else
            @channel = params[:receiver_class].constantize.find(params[:receiver_id]) if params[:receiver_class] == "Channel"
        end
    end
end

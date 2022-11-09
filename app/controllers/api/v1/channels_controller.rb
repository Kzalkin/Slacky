class Api::V1::ChannelsController < ApplicationController
    before_action :authorize_request

    def index
        uid = request.headers['uid']
        @user = User.find(uid)

        render jsonapi: @user.channels, include: [:users]
    end

    def create
        @channel = Channel.new(name: channel_params[:name])

        if @channel.save
            create_channel_with_members

            render json: {status: "Success", message: "Channel successfuly created"}, status: :created
        else
            render json: {status: "Error", errors: @channel.errors}, status: :unprocessable_entity
        end
    end

    def show
        @channel = Channel.find(params[:id])

        render jsonapi: @channel, include: [:users]
    end

    private

    def channel_params
        params.permit(:name, :user_ids)
    end

    def create_channel_with_members
        Userschannel.create!(channel_id: @channel.id, user_id: request.headers['uid'])
        return unless channel_params[:user_ids]
        member_ids = channel_params[:user_ids].scan(/\d|\d\d/).map(&:to_i)

        member_ids.each do |id|
            Userschannel.create!(channel_id: @channel.id, user_id: id)
        end
    end
end

class Api::V1::ChannelsController < ApplicationController
    before_action :authorize_request

    def index
        @user = current_user

        render jsonapi: @user.channels, include: [:members]
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

    def destroy
        @channel = Channel.find(params[:id])
        @channel.destroy

        render json: {status: "Success", message: "Channel successfuly destroyed"}, status: :ok
    end

    private

    def channel_params
        params.permit(:name, :user_ids)
    end

    def create_channel_with_members
        Membership.create!(channel_id: @channel.id, user_id: current_user.id)
        return unless channel_params[:user_ids]
        member_ids = channel_params[:user_ids].scan(/\d|\d\d/).map(&:to_i)

        member_ids.each do |id|
            Membership.create!(channel_id: @channel.id, user_id: id)
        end
    end
end

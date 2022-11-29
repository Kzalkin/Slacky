class Channel < ApplicationRecord
    validates :name, presence: true

    has_many :messages, dependent: :destroy
    has_many :membership, dependent: :destroy
    has_many :members, through: :membership, source: :user

    def self.create_private_room(users, name)
        channel = Channel.create(name: name, is_private: true)
        users.each do |user|
            Membership.create(user_id: user.id, channel_id: channel.id)
        end
        channel
    end
end
class User < ApplicationRecord
    has_secure_password

    has_many :userschannels, dependent: :destroy
    has_many :channels, through: :userschannels

    validates :email, presence: true, uniqueness: true
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :password, presence: true
    validates :password, length: {minimum: 6}
    validates :password_confirmation, presence: true

    has_many :received_direct_messages, foreign_key: :recipient_id, class_name: "DirectMessage"
    has_many :messages, through: :received_direct_messages, source: :message

    has_many :sent_direct_messages, foreign_key: :sender_id, class_name: "DirectMessage"
    has_many :sent_messages, through: :sent_direct_messages, source: :message
end

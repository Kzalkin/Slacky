class User < ApplicationRecord
    has_secure_password

    has_many :messages, dependent: :destroy
    has_many :membership, dependent: :destroy
    has_many :channels, through: :membership

    validates :email, presence: true, uniqueness: true
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :password, presence: true
    validates :password, length: {minimum: 6}
    validates :password_confirmation, presence: true
end

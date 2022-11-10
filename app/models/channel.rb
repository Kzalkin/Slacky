class Channel < ApplicationRecord
    validates :name, presence: true

    has_many :userschannels, dependent: :destroy
    has_many :members, through: :userschannels, source: :user
end

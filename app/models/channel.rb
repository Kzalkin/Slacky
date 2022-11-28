class Channel < ApplicationRecord
    validates :name, presence: true

    has_many :messages
    has_many :members, through: :messages, source: :user
end

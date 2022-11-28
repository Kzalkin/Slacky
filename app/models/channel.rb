class Channel < ApplicationRecord
    validates :name, presence: true

    has_many :messages
    has_many :membership
    has_many :members, through: :membership, source: :user
end

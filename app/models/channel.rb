class Channel < ApplicationRecord
    validates :name, presence: true

    has_many :messages, dependent: :destroy
    has_many :membership, dependent: :destroy
    has_many :members, through: :membership, source: :user
end
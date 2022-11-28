class Message < ApplicationRecord
    validates :body, presence: true

    belongs_to :channel
    belongs_to :user
end

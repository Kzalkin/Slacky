class Message < ApplicationRecord
    validates :body, presence: true
    
    has_many :direct_messages
end

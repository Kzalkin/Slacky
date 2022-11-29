class SerializableMessage < JSONAPI::Serializable::Resource
  type 'Message'
  attribute :body
  has_one :channel
  has_one :user
end

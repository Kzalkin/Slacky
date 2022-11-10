class SerializableDirectMessage < JSONAPI::Serializable::Resource
  type 'Direct Message'
  attribute :created_at
  attribute :updated_at
  has_one :sender
end

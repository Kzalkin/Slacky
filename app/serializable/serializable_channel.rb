class SerializableChannel < JSONAPI::Serializable::Resource
  type 'Channel'
  attributes :id, :name
  has_many :members
end

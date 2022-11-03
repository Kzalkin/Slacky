class SerializableUser < JSONAPI::Serializable::Resource
  type 'User'
  attributes :id, :email
end

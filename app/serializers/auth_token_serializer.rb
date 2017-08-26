class AuthTokenSerializer < ActiveModel::Serializer
  attributes :token, :token_expires_at, :refresh_token, :refresh_token_expires_at
end

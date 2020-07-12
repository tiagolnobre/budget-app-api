# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :name, :email
end

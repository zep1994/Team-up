class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :role, :quote
end

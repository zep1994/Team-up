class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :role, :quote
  has_many :assignments
  has_many :players, through: :assignments
end

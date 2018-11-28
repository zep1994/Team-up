class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :specialty, :leader
  has_many :assignments
  has_many :teams, through: :assignments
end

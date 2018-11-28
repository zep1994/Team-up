class AssignmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :team_id, :player_id
  belongs_to :player
  belongs_to :team
end

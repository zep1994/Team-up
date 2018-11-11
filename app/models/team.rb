class Team < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :players, through: :assignments

  #validations
  validates_presence_of :name


  def assignments_attributes=(assignments_attributes)
      assignments_attributes.values.each do |assignment_attributes|
          if assignment_attributes[:team_id] != ""
              assignment = Assignment.find_or_create_by(assignment_attributes)
              if !self.assignments.include?(assignment)
                  self.assignments.build(assignment_attributes)
              end
          end
      end
  end
end

class Team < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :players, through: :assignments

  #validations
  validates_presence_of :name


  #or accepts_nested_attributes_for :assignments
  #A setter method establishes or reestablishes the value for an instance variable.
  def assignments_attributes=(assignments_attributes)
      assignments_attributes.values.each do |assignment_attributes|
          if assignment_attributes[:team_id] != "" #or present?
              assignment = Assignment.find_or_create_by(assignment_attributes)
              if !self.assignments.include?(assignment)
                  self.assignments.build(assignment_attributes)
              end
          end
      end
  end
end

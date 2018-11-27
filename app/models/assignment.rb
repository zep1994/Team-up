class Assignment < ApplicationRecord
  belongs_to :team
  belongs_to :player

  #validates :name , presence: true
  scope :ordered_by_name, -> { order(name: :asc) }

end

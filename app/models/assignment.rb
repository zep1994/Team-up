class Assignment < ApplicationRecord
  belongs_to :team
  belongs_to :player

  validates :name , presence: true
end

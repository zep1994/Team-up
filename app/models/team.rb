class Team < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :players, through: :assignments

  #validations
  validates_presence_of :name 
end

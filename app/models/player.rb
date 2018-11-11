class Player < ApplicationRecord
  has_secure_password

  has_many :assignments
  has_many :teams, through: :assignments

  validates_presence_of :name
  validates :name, uniqueness: { scope: :specialty, message: "A player with that specialty already exists"}
  validates :name, uniqueness: true
end

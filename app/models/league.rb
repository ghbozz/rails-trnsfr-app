class League < ApplicationRecord
  has_many :clubs
  has_many :transferts, through: :clubs

  validates :name, uniqueness: true
end

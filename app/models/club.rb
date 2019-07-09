class Club < ApplicationRecord
  belongs_to :league
  has_many :players
  has_many :transfert_club
  has_many :transferts, through: :transfert_club

  validates :name, uniqueness: true
end

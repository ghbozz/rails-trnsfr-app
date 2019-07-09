class Club < ApplicationRecord
  belongs_to :league
  has_many :players
  has_many :transferts
end

class Player < ApplicationRecord
  has_many :transferts
  belongs_to :club
end

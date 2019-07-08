class Transfert < ApplicationRecord
  belongs_to :player

  def from_club
    Club.find_by_name(self.from)
  end

  def to_club
    Club.find_by_name(self.to)
  end
end

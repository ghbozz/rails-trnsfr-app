class Player < ApplicationRecord
  has_many :transferts
  belongs_to :club

  def flag_code
    NormalizeCountry(self.nation, :to => :alpha2).downcase if NormalizeCountry(self.nation)
  end

end

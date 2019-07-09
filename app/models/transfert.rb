class Transfert < ApplicationRecord
  belongs_to :player
  has_many :transfert_club
  has_many :clubs, through: :transfert_club
  has_many :leagues, through: :clubs
  # has_many :parts, through: :clubs, class_name: 'League', source: :leagues
  # has_many :leagues, :through => :clubs, source: :league
  # has_many :colabs, through: :tracks, class_name: 'Song', source: :songs

  include PgSearch
  pg_search_scope :global_search,
    against: [ :from, :to ],
    associated_against: {
      player: [ :name, :nation ]
    },
    using: {
      tsearch: { prefix: true }
    }

  def from_club
    Club.find_by_name(self.from)
  end

  def to_club
    Club.find_by_name(self.to)
  end

  def self.filter_by_league(league)
    Transfert.all.select {|t| t.leagues.pluck(:name).include?(league)}
  end
end

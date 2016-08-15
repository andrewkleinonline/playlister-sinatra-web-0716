require 'pry'

class Artist < ActiveRecord::Base
  has_many :songs
  has_many :song_genres, through: :songs
  has_many :genres, through: :song_genres

  def slug
    slugged_name = self.name.downcase
    slugged_name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    slugged_names = self.all.collect {|artist| {artist.slug => artist } }

    slugged_names.detect do |slugged_name|
      slugged_name.keys[0] == slug
    end[slug]
  end

end

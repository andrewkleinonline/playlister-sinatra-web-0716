class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    slugged_name = self.name.downcase
    slugged_name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    slugged_names = self.all.collect {|song| {song.slug => song } }

    slugged_names.detect do |slugged_name|
      slugged_name.keys[0] == slug
    end[slug]
  end
end

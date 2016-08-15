class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs


  def slug
    slugged_name = self.name.downcase
    slugged_name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    slugged_names = self.all.collect {|genre| {genre.slug => genre } }

    slugged_names.detect do |slugged_name|
      slugged_name.keys[0] == slug
    end[slug]
  end
end

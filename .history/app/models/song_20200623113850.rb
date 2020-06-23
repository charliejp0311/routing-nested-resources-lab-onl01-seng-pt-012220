class Song < ActiveRecord::Base
  belongs_to :artist

  def artist_name
    self.try(:artist).try(:name)
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  private
  def a_song
    if @song 
      @song
    else
      flash[:alert] = "Song not found"
      redirect_to artist_songs_path(@artist)
    end
  end
end

module SongsHelper
    def display_song(artist)
      if self.artist == artist 
        artist_song_path(self)
      else
      	flash[:alert] = "Song not found"
       	redirect_to artist_songs_path(artist)
      end
    end
end

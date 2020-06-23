module SongsHelper
    def display_song(artist,song)
      if song.artist == artist 
        artist_song_path(song)
      else
       	artist_songs_path(artist)
      end
    end
end

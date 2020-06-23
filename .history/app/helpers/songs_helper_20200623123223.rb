module SongsHelper
    def display_song(artist,song)
      if song.artist == artist 
        link_to song.title, artist_song_path(song)
      else
       	link_to artist.name, artist_songs_path(artist)
      end
    end
end

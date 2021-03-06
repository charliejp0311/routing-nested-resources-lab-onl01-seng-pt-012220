class SongsController < ApplicationController
  def index
    if params[:artist_id] 
      if Artist.exists?(id: params[:artist_id])
        @song = Artist.find(params[:artist_id]).songs.find(params[:id])
      else
        alert = "Artist not found"
        redirect_to artists_path
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      if Artist.exists?(id: params[:artist_id])
      @artist = Artist.find(id: params[:artist_id])
      if Song.exists?(params[:id]) 
        @song = Song.find(params[:id])
        if @artist.songs.include(@song)
          render artist_song_path(@song)
        else
          flash[:alert]= "Song doesn't belong to this artist"
          redirect_to artist_songs_path(@artist)
        end
      else
        flash[:alert] = "Song not found"
        redirect_to artist_songs_path(id: :artist_id)
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end


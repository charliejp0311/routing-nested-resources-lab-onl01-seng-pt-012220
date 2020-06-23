class SongsController < ApplicationController
  def index
    if params[:artist_id] 
      if params[:artist_id].is_a?(Integer)
        @songs = Artist.find(params[:artist_id]).songs
      else
        redirect_to '/artists'
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @song = Song.find(params[:id])
      binding.pry
      if Artist.find(params[:artist_id]).songs.exclude?(@song)
        redirect_to artist_songs_path
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

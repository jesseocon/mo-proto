class AlbumsController < ApplicationController
  before_filter :find_album, only: [:edit, :update, :show, :destroy]
  def index
    @albums = Album.all
  end
  
  def new
    @album = Album.new(:user_id => current_user.id)
  end
  
  def create
    @album = Album.create(params[:album])
    if @album.save
      redirect_to album_path(@album)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @album.update_attributes(params[:album])
      redirect_to albums_path
    else
      render :edit
    end
  end
  
  def show
  end
  
  def destroy
    @album.destroy
  end
  
  private
    def find_album
      @album = Album.find(params[:id])
    end
end

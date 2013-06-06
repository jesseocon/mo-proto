class AlbumsController < ApplicationController
  before_filter :find_album, only: [:edit, :update, :show, :destroy, :get_pics]
  
  def index
    render :layout => 'grid_layout'
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
    render :layout => 'grid_layout'
  end
  
  def destroy
    @album.destroy
  end
  
  def get_pics
    @pics = @album.incoming_messages
    respond_to do |format|
      format.json { render :json => @pics, :only => [:width, :height, :photo_file_name], :methods => [:photo_url] }
    end
  end
  
  private
    def find_album
      @album = Album.find(params[:id])
    end
end

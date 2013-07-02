class AlbumsController < ApplicationController
  before_filter :find_album, only: [:edit, :update, :show, :destroy, :get_pics, :get_html_pics, :invite, :sync_gmail]
  
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
    @pics = @album.incoming_messages.order('id ASC')
    @current_user = current_user
    next_url = invite_album_url(@album)
    @session_token = session[:token] if session[:token]
    @google_import = GoogleImport.new(next_url: next_url, secure: false, sess: true)
    render :layout => 'foliogrid'
  end
  
  def destroy
    @album.destroy
  end
  
  def invite
    @invites = Invitation.invitation_list(@album.id)
    @current_user = current_user
    @session_token = session[:token]
    @folio_contacts = Contact.where(user_id: current_user.id)
    if session[:token]
      @google_import = GoogleImport.new(single_use_token: session[:token], max_results: 1000, user_id: current_user.id)
      @contacts = @google_import.make_contacts_array
      @contacts = @contacts.concat(@folio_contacts).sort_by { |hash| hash["name"] }
    else
      next_url = sync_gmail_album_url(@album)
      @google_import = GoogleImport.new(next_url: next_url, secure: false, sess: true)
      @contacts = @folio_contacts.sort_by { |hash| hash["name"] }
    end 
    render :layout => 'foliogrid'
  end
  
  def sync_gmail
    @google_import = GoogleImport.new(single_use_token: params[:token])
    session[:token] = @google_import.create_session_token
    redirect_to invite_album_url(@album)
  end
  
  def get_pics
    @pics = @album.incoming_messages
    respond_to do |format|
      format.json { render :json => @pics, :only => [:width, :height], :methods => [:src, :caption] }
    end
  end
  
  def get_html_pics
    page = params[:page].to_i
    per_page = 10
    offset = (per_page * (page - 1)) + 1
    @pics = @album.incoming_messages.order('id ASC').offset(offset).limit(per_page)
    render :layout => false
  end
  
  private
    def find_album
      @album = Album.find(params[:id])
    end
    
end

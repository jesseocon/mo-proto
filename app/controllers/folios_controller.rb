class FoliosController < ApplicationController
  def index
    @folios = Folio.all
  end
  
  def new
    @folio = Folio.new
  end
  
  def create
    @folio = Folio.new(params[:folio])
    if @folio.save
      redirect_to root_url
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def show
    
  end
  
  def destroy
    
  end
  
  def check_availability
    base_url = "https://api.mogreet.com/cm/keyword.check?client_id=1383&token=dcb7872095eb4650c3818088062bbaa6"
    keyword = "&keyword=#{params[:keyword]}"
    format = "&format=json"
    final_url = "#{base_url}#{keyword}#{format}"
    @response = HTTParty.get(final_url)
    @response = @response["response"]["available"]
    respond_to do |format|
      format.json { render :json => @response}
    end
  end
  
  def register_keyword
    base_url = "https://api.mogreet.com/cm/keyword.add?client_id=1383&token=dcb7872095eb4650c3818088062bbaa6&campaign_id=29701"
    keyword = "&keyword=#{params[:keyword]}"
    format = "&format=json"
    final_url = "#{base_url}#{keyword}#{format}"
    @response = HTTParty.get(final_url)
    respond_to do |format|
      format.json { render :json => @response }
    end
  end
  
  def deregister_keyword
    base_url = "https://api.mogreet.com/cm/keyword.remove?client_id=1383&token=dcb7872095eb4650c3818088062bbaa6&campaign_id=29701"
    keyword = "&keyword=#{params[:keyword]}"
    format = "&format=json"
    final_url = "#{base_url}#{keyword}#{format}"
    @response = HTTParty.get(final_url)
    respond_to do |format|
      format.json { render :json => @response }
    end
  end
  
end




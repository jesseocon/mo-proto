class StarsController < ApplicationController
  def create
    @star = Star.create(params[:star])
    if @star.save
      respond_to do |format|
        format.json { render :json => @star}
      end
    else
      render :json => { :errors => @asset.errors.full_messages }
    end
  end
end

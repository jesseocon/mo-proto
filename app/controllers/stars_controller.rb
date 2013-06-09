class StarsController < ApplicationController
  def create
    @star = Star.create(params[:star])
    @star.save
    respond_to do |format|
      format.json
    end
  end
end

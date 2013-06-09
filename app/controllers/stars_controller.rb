class StarsController < ApplicationController
  def create
    @star = Star.create(params[:star])
    @star.save
  end
end

class InvitationsController < ApplicationController
  def create
    array = JSON.parse(params[:users])
    @invitations = Invitation.create_multiple_from_array(array)
    
    respond_to do |format|
      format.json { render :json => @invitations }
    end
  end
end

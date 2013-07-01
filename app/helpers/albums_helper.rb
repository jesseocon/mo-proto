module AlbumsHelper
  def invited?(user_email, album_id)
    Invitation.invitation_list(album_id).collect { |i| i.user_email }.include?(user_email)
  end
  
  def row_class(on_the_list)
    if on_the_list == true
      return "disabled_row"
    else
      return ""
    end
  end
  
  def disabled?(on_the_list)
    if on_the_list == true
      return true
    else
      return false
    end
  end
end

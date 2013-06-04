class InboxController < ApplicationController
  include Mandrill::Rails::WebHookProcessor
  
  def handle_inbound(event_payload)
    puts "HITTING THE CONTROLLER"
    if attachments = event_payload.attachments.presence && IncomingMessage::ACCEPTABLE_FILETYPES.include?(event_payload.attachments.first.type)
      attachments = event_payload.attachments
      @album = Album.find_by_album_handle(event_payload.user_email) rescue nil
      if !@album.nil?
        a1 = attachments.first
        @incoming_message = @album.incoming_messages.new(
          :from => event_payload.user_email,
          :to   => event_payload.recipient_emails.first
        )
        puts "************CONTENT TYPE#{a1.type}"
        @incoming_message.save_photo(a1.name, a1.type, a1.content)
        @incoming_message.save
      end
    end
  end
  
  # def handle_inbound(event_payload)
  #   ## after the app the controller is saving photos
  #   ## move the IncomingMessage.new statement into 
  #   ## the if statement so that all messages without
  #   ## attachments are ignored.  Also add the logic
  #   ## to create multiple records.
  #   puts "***************#{event_payload.user_email}"
  #   @album = Album.find_by_album_handle(event_payload.user_email) rescue nil
  #   if @album.nil? 
  #     puts "***********************I AM IN THE NIL CASE"
  #    #skip entirely 
  #   else
  #     @incoming_message = @album.incoming_messages.new(
  #       :from => event_payload.user_email,
  #       :to   => event_payload.recipient_emails.first 
  #     )
  #     if attachments = event_payload.attachments.presence
  #       # yes, we have at least 1 attachment. Lets look at the first:
  #       a1 = attachments.first
  # 
  #       a1.name
  #       # => e.g. 'sample.pdf'
  #       a1.type
  #       # => e.g. 'application/pdf'
  #       a1.content
  #       # => this is the raw content provided by Mandrill, and will be base64-encoded if not plain text
  #       # e.g. 'JVBERi0xLjMKJcTl8uXrp/Og0MTGCjQgMCBvY ... (etc)'
  #       a1.decoded_content
  #       # => this is the content decoded by Mandrill::Rails, ready to be written as a File or whatever
  #       # e.g. '%PDF-1.3\n%\xC4\xE5 ... (etc)'
  #       @incoming_message.save_photo(a1.name, a1.type, a1.content)
  #     end
  #     @incoming_message.save
  #   end
  # end
     
end

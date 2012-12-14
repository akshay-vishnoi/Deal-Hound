# This will display errors in line, after form submission.
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
 if !(html_tag =~ /<label/)
   %|<div class="fieldWithErrors">#{html_tag} <span class="error">#{instance.error_message.first}</span></div>|.html_safe
 else
   html_tag
 end
end

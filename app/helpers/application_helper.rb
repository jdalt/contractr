module ApplicationHelper
	def full_title(page_title)
		base_title = "Contractr"
		if page_title.empty?
			base_title
		else
      #TODO: still don't totally understanding what is escaping what
		  "#{base_title} | #{page_title}".html_safe 
		end
	end
end

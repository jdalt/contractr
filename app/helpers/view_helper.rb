module ViewHelper
  def icon_ok_remove(status)
    if status
      '<i class="icon-ok"></i>'.html_safe
    else
      '<i class="icon-remove"></i>'.html_safe
    end
  end
end

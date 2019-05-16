module ApplicationHelper
  def app_name
    'Lunch Service'
  end

  def display_status(status)
    icon_class = status 
    icon_class ? content_tag(:span, nil, class: 'glyphicon glyphicon-ok') : content_tag(:span, nil, class: 'glyphicon glyphicon-remove')
  end
end

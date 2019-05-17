module ApplicationHelper
  def app_name
    'Lunch Service'
  end

  def display_status(status)
    icon_class = status ? 'ok' : 'remove'
    content_tag(:span, nil, class: "glyphicon glyphicon-#{icon_class}")
  end
end

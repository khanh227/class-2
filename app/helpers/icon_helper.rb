module IconHelper
  def enabled_icon
    Product.pluck(:enabled) ? 'glyphicon.glyphicon-ok' : 'glyphicon.glyphicon-remove'
  end
end

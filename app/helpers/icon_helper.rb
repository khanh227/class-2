module IconHelper
  def enabled_icon
    Product.new.enabled ? 'glyphicon.glyphicon-ok' : 'glyphicon.glyphicon-remove'
  end
end

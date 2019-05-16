module IconHelper
  def enabled_icon
    Product.pluck(:enabled).each do |e| 
      e ? 'glyphicon.glyphicon-ok' : 'glyphicon.glyphicon-remove'
    end
  end
end

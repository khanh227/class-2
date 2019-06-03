class HomeController < ApplicationController
  def index
    timenow = Time.current.to_date.strftime('%Y-%m-%d')
    @menu = Menu.by_name(timenow).first
  end
end

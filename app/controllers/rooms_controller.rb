class RoomsController < ApplicationController
  def show
  	@messages = Messenger.all
  end
end

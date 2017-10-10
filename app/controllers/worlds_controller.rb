class WorldsController < ApplicationController
  before_action :authorize
  
  def show
    # @messages = Message.all
    @msgs = ["Welcome to the Dark Elf MUD Framework!", "Type help to get started."]
    @user = current_user
  end
end

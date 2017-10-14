class PagesController < ApplicationController
  def show
    render template: "#{params[:page]}"
  end
end

class PagesController < ApplicationController
  def show
    page = params[:id]
    render page
  end
end

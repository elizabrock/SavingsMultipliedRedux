class PagesController < ApplicationController
  def show
    @page = Page.where(slug: params[:id]).first
  end
end

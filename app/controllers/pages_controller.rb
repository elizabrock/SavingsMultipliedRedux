class PagesController < ApplicationController
  skip_before_action :authenticate!

  def show
    @page = Page.where(slug: params[:id]).first
  end
end

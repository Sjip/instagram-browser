class PagesController < ApplicationController
  def home
    @collection = Collection.new
    @collections = Collection.all.order('id desc')
  end
end

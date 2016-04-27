class CollectionsController < ApplicationController
  def show
    if params[:id]
      @collection = Collection.find_by_id(params[:id].to_i)
      InstagramService.new.get_recent_tagged_media(@collection) if @collection.instagram_contents.blank?
      @instagram_contents = @collection.instagram_contents

      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @collection = Collection.create(collections_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def collections_params
    params.require(:collection).permit(
      :end_date,
      :hashtag,
      :start_date)
  end
end